#!/usr/bin/perl

use strict;
use warnings;

use Getopt::Std;
use Net::LDAP;
use Net::SMTP;
use Storable qw(lock_store lock_retrieve);

my %opts;
sub parse_opts
{
	getopts('hU:D:W:C:K:A:l:b:s:v:', \%opts);
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
			"\t-l logfile\tLog file\n",
			"\t-b logfile\tBackup Log file\n",
			"\t-s statefile\tState file\n",
			"\t-t thrcnt\tThreads count\n",
			"\t-v level\tLog verbosity level\n",
			"";
		exit 0;
	}
	die "-U -l -b -s options are required" unless $opts{U} && $opts{l} && $opts{b} && $opts{s};
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

sub load_state
{
	my $state;
	eval {
		$state = lock_retrieve($opts{s});
	};
	$state = {} unless $state;
	return $state;
}

sub save_state
{
	my $state = shift;
	lock_store $state, $opts{s};
}

sub get_mx_sessings
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

sub process_log
{
	my $state = shift;
	my $F;
	my $fname = $opts{l};
	if ($state->{ofs}->{$opts{l}})
	{
		if (-s $opts{l} < $state->{ofs}->{$opts{l}})
		{
			warn "Log rotation $fname -> $opts{b}" if $opts{v};
			$fname = $opts{b};
		}
	}
	open $F, "<", $fname or die "Unable to open log file $fname for reading";
	seek $F, $state->{ofs}->{$opts{l}}, 0 if $state->{ofs}->{$opts{l}};
	while (<$F>)
	{
		process_mbox($1, $2, $3, $4) if /AdvancedFiltering:NewMailBox:<([^>]+)>Domain:<([^>]+)>Client:<([^>]+)>Realm:<([^>]+)>/;
		$state->{ofs}->{$opts{l}} = $fname eq $opts{l} ? tell $F : 0;
		save_state($state);
	}
}

######################################################################

parse_opts;
reconnect_ldap;

my $state = load_state;
process_log($state);
save_state($state);
