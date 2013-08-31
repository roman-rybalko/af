#!/usr/bin/perl

use strict;
use warnings;

use Getopt::Std;
use Net::LDAP;

my %defaults = (
	U => 'ldapi://%2fvar%2frun%2fopenldap%2fldapi',
);

my %opts;
getopts('hU:D:W:C:K:A:q:s:r:1', \%opts) or die "Use -h option";

if ($opts{h})
{
	print "USAGE: $0 [options]\n",
		"OPTIONS:\n",
		"\t-h\t\tThis help screen\n",
		"\t-U URI\t\tLDAP server URI, default $defaults{U}\n",
		"\t-D DN\t\tLDAP bind DN\n",
		"\t-W pw\t\tLDAP bind password\n",
		"\t-C cert\t\tSTARTTLS certificate file\n",
		"\t-K key\t\tSTARTTLS key file\n",
		"\t-A ca\t\tSTARTTLS CA path\n",
		"\t-q param\tQuery for a parameter\n",
		"\t-s service\tSelect hosts with specified service\n",
		"\t-r realm\tSelect hosts with specified realm(s), separated by comma\n",
		"\t-1\t\tOutput a single random value\n",
		"";
	exit 0;
}

foreach(keys %defaults)
{
	$opts{$_} = $defaults{$_} unless exists $opts{$_};
}

my $ldap = Net::LDAP->new($opts{U}) or die "LDAP connection error";
my $ldap_msg;

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
	$ldap_msg = $ldap->start_tls(@options);
	die "start_tls: " . $ldap_msg->error_text if $ldap_msg->is_error;
}

if ($opts{D})
{
	$ldap_msg = $ldap->bind($opts{D}, password => $opts{W}) if $opts{W};
	$ldap_msg = $ldap->bind($opts{D}) if $opts{W};
	die "bind: " . $ldap_msg->error_text if $ldap_msg->is_error;
}

die "-q is not specified" unless $opts{q};
if ($opts{q} eq "hostname")
{
	if ($opts{r})
	{
		@{$opts{r}} = split(/,/, $opts{r});
	}
	else
	{
		# find our realm(s)
		my $base = 'afSHostName='.`hostname`.',ou=system,o=advancedfiltering';
		$ldap_msg = $ldap->search(
			filter => '(objectClass=afSHost)',
			base => $base,
			scope => 'base',
			attrs => ['afSHostRealm']);
		die "search(base=$base): " . $ldap_msg->error_text if $ldap_msg->is_error;
		@{$opts{r}} = $ldap_msg->entry(0)->get_value('afSHostRealm');
	}
	my $filter = '(&(objectClass=afSHost)';
	$filter .= '(|';
	$filter .= "(afSHostRealm=$_)" foreach @{$opts{r}};
	$filter .= ')';
	$filter .= "(afshostservicename=$opts{s})" if $opts{s};
	$filter .= ')';
	$ldap_msg = $ldap->search(
		filter => $filter,
		base => 'ou=system,o=advancedfiltering',
		scope => 'sub', # scope=one, but mdb does not handle it efficiently
		attrs => ['afSHostName']);
	die "search(filter=$filter): " . $ldap_msg->error_text if $ldap_msg->is_error;
	if ($opts{1})
	{
		$ldap_msg->pop_entry while $ldap_msg->count > 1;
	}
	print $_->get_value('afSHostRealm'),"\n" foreach $ldap_msg->entries;
}
