package AdvancedFiltering::DB::smtp;

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(get_domain_client get_mailbox_data);

use AdvancedFiltering::DB qw(get_client_realm);
use AdvancedFiltering::LDAP qw(get_ldap_value);

sub get_domain_client
{
	my $domain = shift;
	return get_ldap_value("afSSMTPDomainName=$domain,afSServiceName=smtp,ou=system,o=advancedfiltering", 'afSSMTPDomainClientName');
}

sub get_mailbox_data
{
	my $mailbox = shift;
	my ($local_part, $domain) = split /\@/, $mailbox;
	die "DB: mailbox parse failed" unless $local_part && $domain;
	my $client = get_domain_client($domain);
	return undef unless $client;
	my $realm = get_client_realm($client);
	return undef unless grep { $_ eq $realm } get_my_realms;
	my $alias = get_ldap_value("afUSMTPDomainName=$domain,afUClientName=$client,afUServiceName=smtp+afUServiceRealm=$realm,ou=user,o=advancedfiltering", 'afUSMTPDomainAliasName');
	$domain = $alias if $alias;
	my $data = get_ldap_value("afUSMTPDMBLocalPart=$local_part,afUSMTPDomainName=$domain,afUClientName=$client,afUServiceName=smtp+afUServiceRealm=$realm,ou=user,o=advancedfiltering", ['afUSMTPDMBTimeUpdated', 'afUSMTPDMBIsAbsent']);
	return {
		realm => $realm,
		client => $client,
		domain => $domain,
		local_part => $local_part,
		update_time => $data ? $data->{afUSMTPDMBTimeUpdated} : undef,
		is_absent => $data ? $data->{afUSMTPDMBIsAbsent} : undef,
	};
}

1;
