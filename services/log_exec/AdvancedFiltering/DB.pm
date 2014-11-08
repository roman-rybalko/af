package AdvancedFiltering::DB;

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(get_my_realms get_service_hosts get_mailbox_submission_info get_mailbox_smtp_info);

use AdvancedFiltering::LDAP qw(get_ldap_value find_ldap_values);
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
 	my @hosts = find_ldap_values('ou=system,o=advancedfiltering', {objectClass => 'afSHost', afSHostRealm => $realm, afSHostServiceName => $service}, 'afSHostName');
 	@hosts = map {
		my $value = get_ldap_value("afSHostServiceName=$service,afSHostName=$_,ou=system,o=advancedfiltering", 'afSHServiceTCPPort');
		$value ? $_ . ":" . $value : $_;
	} @hosts;
 	return @hosts;
}

sub get_domain_client
{
	my $domain = shift;
}

sub get_client_realm
{
	my $client = shift;
}

sub get_mailbox_submission_info
{
	my $mailbox = shift;
	my ($local_part, $domain) = split /\@/, $mailbox;
	die "mailbox parse failed" unless $local_part && $domain;
	my $client = get_domain_client($domain);
	return undef unless $client;
	my $realm = get_client_realm($client);
	return undef unless grep { $_ eq $realm } get_my_realms;
	my $alias = get_ldap_value("afUSubmissionDomainName=$domain,afUClientName=$client,afUServiceName=submission+afUServiceRealm=$realm,ou=user,o=advancedfiltering", 'afUSubmissionDomainAliasName');
	$domain = $alias if $alias;
	my $update_time = get_ldap_value("afUSubmissionDMBLocalPart=$local_part,afUSubmissionDomainName=$domain,afUClientName=$client,afUServiceName=submission+afUServiceRealm=$realm,ou=user,o=advancedfiltering", 'afUSubmissionDMBTimeUpdated');
	return {
		realm => $realm,
		client => $client,
		domain => $domain,
		local_part => $local_part,
		update_time => $update_time,
	};
}

sub get_mailbox_smtp_info
{
	my $mailbox = shift;
	my ($local_part, $domain) = split /\@/, $mailbox;
	die "mailbox parse failed" unless $local_part && $domain;
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
