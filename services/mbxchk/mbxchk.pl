#!/usr/bin/perl

use strict;
use warnings;

use Getopt::Std;
use Net::LDAP;
use Net::SMTP;
use Fcntl qw(:flock);
use Storable qw(fd_retrieve);
use Data::Dumper;
use FindBin;
use lib ($FindBin::Bin);
use AdvancedFiltering::SMTP;

my %opts;
sub parse_opts
{
	getopts('hU:D:W:C:K:A:t:T:f:S:v:', \%opts);
	if ($opts{h})
	{
		print "USAGE: $0 [options]\n",
			"OPTIONS:\n",
			"\t-h\tThis help screen\n",
			"\t-U URI\tLDAP server URI\n",
			"\t-D DN\tLDAP bind DN\n",
			"\t-W pw\tLDAP bind password\n",
			"\t-C cert\t\tLDAP STARTTLS certificate file\n",
			"\t-K key\t\tLDAP STARTTLS key file\n",
			"\t-A ca\t\tLDAP STARTTLS CA path\n",
			"\t-t taskdir\tTask files directory\n",
			"\t-T timeout\tSMTP timeout in seconds\n",
			"\t-f sender\tSMTP Sender\n",
			"\t-S dir\tSSL directory (.../exim/ssl)\n",
			"\t-v level\tLog verbosity level\n",
			"";
		exit 0;
	}
	die "-U -t -T options are required" unless $opts{U} && $opts{t} && $opts{T};
	$opts{v} = 0 unless $opts{v};
	$opts{f} = "" unless $opts{f};
}

my $ldap;
sub reconnect_ldap
{
	$ldap = Net::LDAP->new($opts{U}) or die "LDAP connection error";
	
	if ($opts{C})
	{
		die '-K option is required' unless $opts{K};
		my @options = (
			clientcert => $opts{C},
			clientkey => $opts{K},
			);
		if ($opts{A})
		{
			push @options =>
				verify => 'require',
				capath => $opts{A},
				checkcrl => 1;
		}
		my $ldap_msg = $ldap->start_tls(@options);
		die "start_tls: " . $ldap_msg->error_text if $ldap_msg->is_error;
	}
	
	if ($opts{D})
	{
		die "-W option is required" unless $opts{W};
		my $ldap_msg = $ldap->bind($opts{D}, password => $opts{W});
		die "bind: " . $ldap_msg->error_text if $ldap_msg->is_error;
	}
}

sub get_mx_settings
{
	my $mbox_settings = shift;
	my $mx_settings = [];

	my @attrs = ('afUSMTPMXHostName',
		'afUSMTPMXTCPPort',
		'afUSMTPMXAuthUser',
		'afUSMTPMXAuthPassword',
		'afUSMTPMXTLSRequired',
		'afUSMTPMXAuthTLSCertificate',
		'afUSMTPMXAuthTLSKey',
		'afUSMTPMXAuthTLSCA');
	foreach my $base("ou=settings,afUSMTPDMBLocalPart=$mbox_settings->{mailbox},afUSMTPDomainName=$mbox_settings->{domain},afUClientName=$mbox_settings->{client},afUServiceRealm=$mbox_settings->{realm}+afUServiceName=smtp,ou=user,o=advancedfiltering",
		"ou=settings,afUSMTPDomainName=$mbox_settings->{domain},afUClientName=$mbox_settings->{client},afUServiceRealm=$mbox_settings->{realm}+afUServiceName=smtp,ou=user,o=advancedfiltering",
		"ou=settings,afUClientName=$mbox_settings->{client},afUServiceRealm=$mbox_settings->{realm}+afUServiceName=smtp,ou=user,o=advancedfiltering")
	{
		my $ldap_msg = $ldap->search(
			base => $base,
			scope => 'sub',
			filter => "(objectClass=afUSMTPMailExchanger)",
			attrs => [@attrs],
		);
		foreach my $ldap_entry ($ldap_msg->entries)
		{
			push @$mx_settings => {map {$_ => $ldap_entry->get_value($_)} (@attrs)};
		}
		last if @$mx_settings;
	}
	return $mx_settings;
}

sub check_smtp
{
	my $mbox_settings = shift;
	my $mx1_settings = shift;
	my $smtp = Net::SMTP->new(
		$mx1_settings->{afUSMTPMXHostName},
		Port => $mx1_settings->{afUSMTPMXTCPPort},
		Timeout => $opts{T},
	) or die "Can't connect to SMTP server";
	die "STARTTLS is not supported but required"
		if $mx1_settings->{afUSMTPMXTLSRequired}
		&& !$smtp->supports('STARTTLS');
	die "AUTH CRAM-MD5 & STARTTLS is not supported but AUTH is required"
		if $mx1_settings->{afUSMTPMXAuthUser}
		&& (!$smtp->supports('AUTH') || $smtp->supports('AUTH') !~ /CRAM\-MD5/)
		&& !$smtp->supports('STARTTLS');
	if (
		$mx1_settings->{afUSMTPMXTLSRequired}
		|| ($mx1_settings->{afUSMTPMXAuthUser} && (!$smtp->supports('AUTH') || $smtp->supports('AUTH') !~ /CRAM\-MD5/))
		)
	{
		my %args;
		$args{SSL_cert_file} = "$opts{S}/$mx1_settings->{afUSMTPMXAuthTLSCertificate}.crt" if $mx1_settings->{afUSMTPMXAuthTLSCertificate};
		$args{SSL_key_file} = "$opts{S}/$mx1_settings->{afUSMTPMXAuthTLSKey}.key" if $mx1_settings->{afUSMTPMXAuthTLSKey};
		if ($mx1_settings->{afUSMTPMXAuthTLSCA})
		{
			$args{SSL_ca_path} = "$opts{S}/$mx1_settings->{afUSMTPMXAuthTLSCA}";
			$args{SSL_check_crl} = 1;
			$args{SSL_verify_mode} = 0x01;
		}
		$smtp->starttls(%args) or die "STARTTLS failed";
	}
	if ($mx1_settings->{afUSMTPMXAuthUser})
	{
		$smtp->auth($mx1_settings->{afUSMTPMXAuthUser}, $mx1_settings->{afUSMTPMXAuthPassword}) or die "AUTH failed";
	}
	$smtp->mail($opts{f}) or die "MAIL failed";
	my $existing = $smtp->to("$mbox_settings->{mailbox}\@$mbox_settings->{domain}");
	$smtp->quit();
	return $existing;
}

sub check_mailbox
{
	my $mbox_settings = shift;
	my $mx_settings = shift;
	my $existing = undef;
	foreach my $mx1_settings (@$mx_settings)
	{
		eval {
			$existing = check_smtp($mbox_settings, $mx1_settings);
		};
		warn "$mx1_settings->{afUSMTPMXHostName}:$mx1_settings->{afUSMTPMXTCPPort}: $@" if $@ && $opts{v};
		last if defined $existing;
	}
	return $existing;
}

sub update_mailbox
{
	my $mbox_settings = shift;
	my $existing = shift;
	my $base = "afUSMTPDMBLocalPart=$mbox_settings->{mailbox},afUSMTPDomainName=$mbox_settings->{domain},afUClientName=$mbox_settings->{client},afUServiceRealm=$mbox_settings->{realm}+afUServiceName=smtp,ou=user,o=advancedfiltering";
	my $ldap_msg = $ldap->search(
		base => $base,
		scope => 'base',
		filter => "(objectClass=*)",
		attrs => ['afUSMTPDMBTimeUpdated', 'afUSMTPDMBIsAbsent'],
	);
	unless ($ldap_msg->is_error)
	{
		my $ldap_entry = ($ldap_msg->entries)[0];
		$ldap_entry->replace('afUSMTPDMBTimeUpdated' => time);
		$ldap_entry->delete('afUSMTPDMBIsAbsent') if $existing && $ldap_entry->exists('afUSMTPDMBIsAbsent');
		$ldap_entry->add('afUSMTPDMBIsAbsent' => 'TRUE') if !$existing && !$ldap_entry->exists('afUSMTPDMBIsAbsent');
		$ldap_msg = $ldap_entry->update($ldap);
		die 'update_mailbox[update:$base]: ' . $ldap_msg->error_text if $ldap_msg->is_error;
	}
	else
	{
		my %attrs = ('afUSMTPDMBTimeUpdated' => time);
		$attrs{'afUSMTPDMBIsAbsent'} = 'TRUE' unless $existing;
		$ldap_msg = $ldap->add(
			$base,
			attr => [
				'objectClass' => 'afUSMTPDMailBox',
				'afUSMTPDMBLocalPart' => $mbox_settings->{mailbox},
				%attrs
			]
		);
		die 'update_mailbox[add:$base]: ' . $ldap_msg->error_text if $ldap_msg->is_error;
	}
}

sub process_mbox
{
	my $mbox_settings = shift;
	my $mx_settings = get_mx_settings($mbox_settings);
	my $existing = check_mailbox($mbox_settings, $mx_settings);
	update_mailbox($mbox_settings, $existing) if defined $existing;
}

sub process_tasks
{
	my $D;
	opendir $D, $opts{t};
	while (my $fname = readdir $D)
	{
		next if $fname =~ /^\./;
		my $fpath = "$opts{t}/$fname";
		my $F;
		unless (open $F, "<", $fpath)
		{
			warn "Unable to open file $fpath for reading" if $opts{v} > 1;
			next;
		}
		unless (flock $F, LOCK_EX|LOCK_NB)
		{
			warn "Unable to lock file $fpath exclusively" if $opts{v} > 1;
			next;
		}
		my $mbox_settings;
		eval {
			$mbox_settings = fd_retrieve($F);
		};
		unless ($mbox_settings
			&& defined $mbox_settings->{mailbox}
			&& defined $mbox_settings->{domain}
			&& defined $mbox_settings->{client}
			&& defined $mbox_settings->{realm})
		{
			warn "Task file $fpath is broken (", Dumper($mbox_settings), ")";
			unlink $fpath;
			next;
		}
		process_mbox($mbox_settings);
		unlink $fpath;
		warn "$fpath (", Dumper($mbox_settings), ") processed successfully" if $opts{v} > 1;
	}
}

######################################################################

parse_opts;
reconnect_ldap;

process_tasks;
