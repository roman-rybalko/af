package AdvancedFiltering::DB::submission;

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(get_mailbox_data add_mailbox update_mailbox delete_mailbox);

use AdvancedFiltering::DB qw(get_my_realms get_client_realm);
use AdvancedFiltering::DB::smtp qw(get_domain_client);
use AdvancedFiltering::LDAP qw(get_ldap_value add_ldap_object update_ldap_object delete_ldap_object);

sub get_mailbox_data
{
	my $mailbox = shift;
	my ($local_part, $domain) = split /\@/, $mailbox;
	die "DB: mailbox parse failed" unless $local_part && $domain;
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

sub add_mailbox
{
	my $data = shift;
	return add_ldap_object("afUSubmissionDMBLocalPart=$data->{local_part},afUSubmissionDomainName=$data->{domain},afUClientName=$data->{client},afUServiceName=submission+afUServiceRealm=$data->{realm},ou=user,o=advancedfiltering",
		{objectClass => 'afUSubmissionDMailBox', afUSubmissionDMBTimeUpdated => $data->{update_time}});
}

sub update_mailbox
{
	my $data = shift;
	return update_ldap_object("afUSubmissionDMBLocalPart=$data->{local_part},afUSubmissionDomainName=$data->{domain},afUClientName=$data->{client},afUServiceName=submission+afUServiceRealm=$data->{realm},ou=user,o=advancedfiltering",
		{afUSubmissionDMBTimeUpdated => $data->{update_time}});
}

sub delete_mailbox
{
	my $data = shift;
	return delete_ldap_object("afUSubmissionDMBLocalPart=$data->{local_part},afUSubmissionDomainName=$data->{domain},afUClientName=$data->{client},afUServiceName=submission+afUServiceRealm=$data->{realm},ou=user,o=advancedfiltering");
}

1;
