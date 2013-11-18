#!/usr/bin/perl

use strict;
use warnings;

use Getopt::Std;
use Net::LDAP;

my %opts;
sub parse_opts
{
	getopts('hU:D:W:C:K:A:n:s:v:', \%opts);
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
			"\t-n hostname\tHostname the setup for\n",
			"\t-s data\tSyncRepl data"
			. " (binddn= bindmethod= credentials="
			. " tls_cert= tls_key= tls_cacertdir= tls_reqcert= tls_crlcheck="
			. " syncdata= logbase= type= retry= timeout=)\n",
			"\t-v level\tLog verbosity level\n",
			"";
		exit 0;
	}
	die "-U -n -s options are required" unless $opts{U} && $opts{n} && $opts{s};
	$opts{v} = 0 unless $opts{v};
	warn "syncrepl: $opts{s}" if $opts{v} > 1;
}

my $syncrepl_data = "";

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

sub find_user_db_dn
{
	my $ldap_msg = $ldap->search(
		filter => '(&(objectClass=olcDatabaseConfig)(olcSuffix=ou\=user\,o\=advancedfiltering))',
		base => 'cn=config',
		scope => 'sub',
		attrs => ['dn'],
	);
	die 'find_user-db_dn: ' . $ldap_msg->error_text if $ldap_msg->is_error;
	die "User db is not found" unless $ldap_msg->entries;
	die "Ambiguous user db" if scalar($ldap_msg->entries) > 1;
	my $dn = ($ldap_msg->entries)[0]->dn;
	warn "find_user_db_dn: $dn" if $opts{v} > 1;
	return $dn;
}

sub get_curr_repl_data
{
	my $dn = shift;
	my $ldap_msg = $ldap->search(
		filter => '(objectClass=*)',
		base => $dn,
		scope => 'base',
		attrs => ['olcSyncRepl'],
	);
	die 'get_curr_repl_data: ' . $ldap_msg->error_text if $ldap_msg->is_error;
	my $ldap_values = ($ldap_msg->entries)[0]->get_value('olcSyncRepl', asref => 1);
	$ldap_values = [] unless $ldap_values;
	my $result = [];
	foreach (@$ldap_values)
	{
		my $entry = {source => $_};
		$entry->{id} = $1 if /rid=(\d+)/i;
		$entry->{host} = $1 if m~provider=\S+?//(\S+)~i;
		$entry->{service} = $1 if /searchbase=\S*afUServiceName=([^\+,]+)/i;
		$entry->{realm} = $1 if /searchbase=\S*afUServiceRealm=([^\+,]+)/i;
		push @$result => $entry;
	}
	return $result;
}

sub get_need_repl_data
{
	my $ldap_msg = $ldap->search(
		base => "afSHostName=$opts{n},ou=system,o=advancedfiltering",
		scope => 'base',
		filter => '(objectClass=*)',
		attrs => ['afSHostRealm','afSHDBSyncServiceName'],
	);
	die 'get_need_repl_data: ' . $ldap_msg->error_text if $ldap_msg->is_error;
	my $realms = ($ldap_msg->entries)[0]->get_value('afSHostRealm', asref => 1);
	die "get_need_repl_data: no realms found for $opts{n}" unless $realms;
	my $services = ($ldap_msg->entries)[0]->get_value('afSHDBSyncServiceName', asref => 1);
	die "get_need_repl_data: no services found for $opts{n}" unless $services;
	my $result = [];
	for my $realm (@$realms)
	{
		for my $service (@$services)
		{
			$ldap_msg = $ldap->search(
				base => 'ou=system,o=advancedfiltering',
				scope => 'sub',
				filter => "(&(objectClass=afSHost)(afSHostRealm=$realm)(afSHDBSyncServiceName=$service))",
				attrs => ['afSHostName'],
			);
			die "get_need_repl_data[realm=$realm,service=$service]: " . $ldap_msg->error_text if $ldap_msg->is_error;
			foreach my $ldap_entry ($ldap_msg->entries)
			{
				my $entry = {};
				$entry->{host} = $ldap_entry->get_value('afSHostName');
				$entry->{service} = $service;
				$entry->{realm} = $realm;
				next if $entry->{host} eq $opts{n};
				push @$result => $entry;
			}
		}
	}
	return $result;
}

my $unique_id = 100;
my %unique_id_cache;
sub get_unique_id
{
	while ($unique_id_cache{++$unique_id}) {}
	return $unique_id;
}
sub add_unique_id
{
	my $id = shift;
	$unique_id_cache{$id} = 1;
}

sub calc_update_repl_data
{
	my $curr_data = shift;
	my $need_data = shift;
	my $del_data = [];
	my $add_data = [];
	
	my $curr_cache_hsr = {};
	foreach my $entry (@$curr_data)
	{
		add_unique_id($entry->{id}) if $entry->{id};
		$curr_cache_hsr->{$entry->{host}}->{$entry->{service}}->{$entry->{realm}} = 1;
	}
	
	my $need_cache_hsr = {};
	foreach my $entry (@$need_data)
	{
		unless ($curr_cache_hsr->{$entry->{host}}->{$entry->{service}}->{$entry->{realm}})
		{
			$entry->{id} = get_unique_id unless $entry->{id};
			push @$add_data => $entry;
		}
		$need_cache_hsr->{$entry->{host}}->{$entry->{service}}->{$entry->{realm}} = 1;
	}
	
	foreach my $entry (@$curr_data)
	{
		unless ($need_cache_hsr->{$entry->{host}}->{$entry->{service}}->{$entry->{realm}})
		{
			push @$del_data => $entry;
		}
	}	

	if ($opts{v})
	{
		warn "calc_update_repl_data[del]: id=$_->{id} host=$_->{host} service=$_->{service} realm=$_->{realm}" foreach @$del_data;
		warn "calc_update_repl_data[add]: id=$_->{id} host=$_->{host} service=$_->{service} realm=$_->{realm}" foreach @$add_data;
	}
	
	return ($del_data, $add_data);
}

sub get_source
{
	my $entry = shift;
	return $entry->{source} if $entry->{source};
	return "rid=$entry->{id}"
		. " provider=ldap://$entry->{host}"
		. " searchbase=afUServiceName=$entry->{service}+afUServiceRealm=$entry->{realm},ou=user,o=advancedfiltering"
		. " $opts{s}";
}

sub update_repl_data
{
	my $dn = shift;
	my $del_data = shift;
	my $add_data = shift;
	unless (@$del_data || @$add_data)
	{
		warn 'update_repl_data: no data' if $opts{v} > 1;
		return;
	}
	my $del_ldap_values = [];
	push @$del_ldap_values => get_source($_) foreach @$del_data;
	my $add_ldap_values = [];
	push @$add_ldap_values => get_source($_) foreach @$add_data;
	my $ldap_msg = $ldap->search(
		filter => '(objectClass=*)',
		base => $dn,
		scope => 'base',
		attrs => ['olcSyncRepl'],
	);
	die 'update_repl_data: ' . $ldap_msg->error_text if $ldap_msg->is_error;
	my $ldap_entry = ($ldap_msg->entries)[0];
	$ldap_entry->changetype('modify');
	$ldap_entry->delete('olcSyncRepl' => $del_ldap_values) if @$del_ldap_values;
	$ldap_entry->add('olcSyncRepl' => $add_ldap_values) if @$add_ldap_values;
	warn "update_repl_data: " . $ldap_entry->ldif if $opts{v} > 1;
	$ldap_msg = $ldap_entry->update($ldap);
	die 'update_repl_data[update]: ' . $ldap_msg->error_text if $ldap_msg->is_error;
}

######################################################################

parse_opts;
reconnect_ldap;

my $db_dn = find_user_db_dn;
my $curr_data = get_curr_repl_data($db_dn);
my $need_data = get_need_repl_data;
my ($del_data, $add_data) = calc_update_repl_data($curr_data, $need_data);
update_repl_data($db_dn, $del_data, $add_data);
