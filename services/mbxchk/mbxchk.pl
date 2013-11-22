#!/usr/bin/perl

use strict;
use warnings;

use Getopt::Std;
use Net::LDAP;
use Net::SMTP;
use Fcntl qw(:flock);
use Storable qw(fd_retrieve);
use Data::Dumper;

my %opts;
sub parse_opts
{
	getopts('hU:D:W:C:K:A:t:v:', \%opts);
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
			"\t-v level\tLog verbosity level\n",
			"";
		exit 0;
	}
	die "-U -t options are required" unless $opts{U} && $opts{t};
	$opts{v} = 0 unless $opts{v};
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
	my $mailbox = shift;
	my $domain = shift;
	my $client = shift;
	my $realm = shift;
	my $mx_settings = [];

	my @attrs = ('afUSMTPMXHostName',
		'afUSMTPMXTCPPort',
		'afUSMTPMXAuthUser',
		'afUSMTPMXAuthPassword',
		'afUSMTPMXIsTLSRequired',
		'afUSMTPMXAuthTLSCertificate',
		'afUSMTPMXAuthTLSKey',
		'afUSMTPMXAuthTLSCA');
	foreach my $base("ou=settings,afUSMTPDMBLocalPart=$mailbox,afUSMTPDomainName=$domain,afUClientName=$client,afUServiceRealm=$realm+afUServiceName=smtp,ou=user,o=advancedfiltering",
		"ou=settings,afUSMTPDomainName=$domain,afUClientName=$client,afUServiceRealm=$realm+afUServiceName=smtp,ou=user,o=advancedfiltering",
		"ou=settings,afUClientName=$client,afUServiceRealm=$realm+afUServiceName=smtp,ou=user,o=advancedfiltering")
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

sub check_mailbox
{
	my $mx_settings = shift;
	my $existing = 0;
	# TODO
}

sub update_mailbox
{
	my $mailbox = shift;
	my $domain = shift;
	my $client = shift;
	my $realm = shift;
	my $existing = shift;
	my $base = "afUSMTPDMBLocalPart=$mailbox,afUSMTPDomainName=$domain,afUClientName=$client,afUServiceRealm=$realm+afUServiceName=smtp,ou=user,o=advancedfiltering";
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
				'afUSMTPDMBLocalPart' => $mailbox,
				%attrs
			]
		);
		die 'update_mailbox[add:$base]: ' . $ldap_msg->error_text if $ldap_msg->is_error;
	}
}

sub process_mbox
{
	my $mailbox = shift;
	my $domain = shift;
	my $client = shift;
	my $realm = shift;
	my $mx_settings = get_mx_settings($mailbox, $domain, $client, $realm);
	my $existing = check_mailbox($mx_settings);
	update_mailbox($mailbox, $domain, $client, $realm, $existing);
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
		my $data;
		eval {
			$data = fd_retrieve($F);
		};
		unless ($data
			&& defined $data->{mailbox}
			&& defined $data->{domain}
			&& defined $data->{client}
			&& defined $data->{realm})
		{
			warn "Task file $fpath is broken (", Dumper($data), ")";
			unlink $fpath;
			next;
		}
		process_mbox($data->{mailbox}, $data->{domain}, $data->{client}, $data->{realm});
		unlink $fpath;
		warn "$fpath (", Dumper($data), ") processed successfully" if $opts{v} > 1;
	}
}

######################################################################

parse_opts;
reconnect_ldap;

process_tasks;
