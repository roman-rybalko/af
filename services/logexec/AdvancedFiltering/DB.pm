package AdvancedFiltering::DB;

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(get_my_realms get_service_hosts get_domain_client get_client_realm);

use AdvancedFiltering::LDAP qw(get_ldap_value find_ldap_value);
use AdvancedFiltering::Conf qw(get_conf_value);

sub get_my_realms
{
	my @realms = get_ldap_value('afSHostName='.get_conf_value('hostname').',ou=system,o=advancedfiltering', 'afSHostRealm');
	return @realms;
}

sub get_service_hosts
{
	my $realm = shift;
	my $service = shift;
 	my @hosts = find_ldap_value('ou=system,o=advancedfiltering', {objectClass => 'afSHost', afSHostRealm => $realm, afSHostServiceName => $service}, 'afSHostName');
 	@hosts = map {
		my $value = get_ldap_value("afSHostServiceName=$service,afSHostName=$_,ou=system,o=advancedfiltering", 'afSHServiceTCPPort');
		$value ? $_ . ":" . $value : $_;
	} @hosts;
 	return @hosts;
}

sub get_client_realm
{
	my $client = shift;
	return get_ldap_value("afSClientName=$client,ou=system,o=advancedfiltering", 'afSClientRealm');
}

1;
