package AdvancedFiltering::DB::smtp;

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(get_domain_client get_mailbox_data get_mx_data add_mailbox update_mailbox delete_mailbox);

use AdvancedFiltering::DB qw(get_my_realms get_client_realm);
use AdvancedFiltering::LDAP qw(get_ldap_value find_ldap_value add_ldap_object update_ldap_object delete_ldap_object);

sub get_domain_client
{
	my $domain = shift;
	die "USAGE: AdvancedFiltering::DB::smtp::get_domain_client<domain>" unless defined $domain;
	return get_ldap_value("afSSMTPDomainName=$domain,afSServiceName=smtp,ou=system,o=advancedfiltering", 'afSSMTPDomainClientName');
}

sub get_mailbox_data
{
	my $mailbox = shift;
	die "USAGE: AdvancedFiltering::DB::smtp::get_mailbox_data<mailbox>" unless defined $mailbox;
	my ($local_part, $domain) = split /\@/, $mailbox;
	die "AdvancedFiltering::DB::smtp::get_mailbox_data: mailbox parse failed" unless defined($local_part) && defined($domain);
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
		$data ? (update_time => $data->{afUSMTPDMBTimeUpdated}, absent => $data->{afUSMTPDMBIsAbsent}) : (),
	};
}

#
# out:
# host - host:port
# auth_user
# auth_password
# tls_required
# tls_cert_name
# tls_key_name
# tls_ca_name
#
sub get_mx_data
{
	my $realm = shift;
	my $client = shift;
	my $domain = shift;
	my $local_part = shift;
	die "USAGE: AdvancedFiltering::DB::smtp::get_mx_data<realm><client><domain>[local_part]" unless defined($realm) && defined($client) && defined($domain);
	my @ldap_dn;
	if (defined $realm && defined $client)
	{
		unshift @ldap_dn => "afUClientName=$client,afUServiceName=smtp+afUServiceRealm=$realm,ou=user,o=advancedfiltering";
		if (defined $domain)
		{
			unshift @ldap_dn => "afUSMTPDomainName=$domain,afUClientName=$client,afUServiceName=smtp+afUServiceRealm=$realm,ou=user,o=advancedfiltering";
			if (defined $local_part)
			{
				unshift @ldap_dn => "afUSMTPDMBLocalPart=$local_part,afUSMTPDomainName=$domain,afUClientName=$client,afUServiceName=smtp+afUServiceRealm=$realm,ou=user,o=advancedfiltering";
			}
		}
	}
	foreach my $ldap_dn (@ldap_dn)
	{
		my @mx_name = get_ldap_value($ldap_dn, 'afUSMTPMXName');
		my @mx_data;
		foreach my $mx_name (@mx_name)
		{
			my $data = get_ldap_value("afUSMTPMXName=$mx_name,$ldap_dn", ['afUSMTPMXHostName', 'afUSMTPMXTCPPort', 'afUSMTPMXAuthUser', 'afUSMTPMXAuthPassword', 'afUSMTPMXTLSRequired', 'afUSMTPMXAuthTLSCertificate', 'afUSMTPMXAuthTLSKey', 'afUSMTPMXAuthTLSCA']);
			next unless $data;
			my $mx_data = {};
			$mx_data->{host} = $data->{afUSMTPMXTCPPort} ? "$data->{afUSMTPMXHostName}:$data->{afUSMTPMXTCPPort}" : $data->{afUSMTPMXHostName};
			if ($data->{afUSMTPMXAuthUser})
			{
				$mx_data->{auth_user} = $data->{afUSMTPMXAuthUser};
				$mx_data->{auth_password} = $data->{afUSMTPMXAuthPassword};
			}
			$mx_data->{tls_required} = 1 if $data->{afUSMTPMXTLSRequired};
			if ($data->{afUSMTPMXAuthTLSCertificate})
			{
				$mx_data->{tls_cert_name} = $data->{afUSMTPMXAuthTLSCertificate};
				$mx_data->{tls_key_name} = $data->{afUSMTPMXAuthTLSKey};
			}
			$mx_data->{tls_ca_name} = $data->{afUSMTPMXAuthTLSCA} if $data->{afUSMTPMXAuthTLSCA};
			push @mx_data => $mx_data;
		}
		return @mx_data if @mx_name;
	}
	return ();
}

sub add_mailbox
{
	my $realm = shift;
	my $client = shift;
	my $domain = shift;
	my $local_part = shift;
	die "USAGE: AdvancedFiltering::DB::smtp::add_mailbox<realm><client><domain><local_part>" unless defined($realm) && defined($client) && defined($domain) && defined($local_part);
	return add_ldap_object("afUSMTPDMBLocalPart=$local_part,afUSMTPDomainName=$domain,afUClientName=$client,afUServiceName=smtp+afUServiceRealm=$realm,ou=user,o=advancedfiltering",
		{objectClass => 'afUSMTPDMailBox', afUSMTPDMBTimeUpdated => time, });
}

sub update_mailbox
{
	my $realm = shift;
	my $client = shift;
	my $domain = shift;
	my $local_part = shift;
	my $absent = shift;
	die "USAGE: AdvancedFiltering::DB::smtp::update_mailbox<realm><client><domain><local_part>[absent]" unless defined($realm) && defined($client) && defined($domain) && defined($local_part);
	return update_ldap_object("afUSMTPDMBLocalPart=$local_part,afUSMTPDomainName=$domain,afUClientName=$client,afUServiceName=smtp+afUServiceRealm=$realm,ou=user,o=advancedfiltering",
		{afUSMTPDMBTimeUpdated => time, defined($absent) ? (afUSMTPDMBIsAbsent => $absent ? 'TRUE' : []) : (), });
}

sub delete_mailbox
{
	my $realm = shift;
	my $client = shift;
	my $domain = shift;
	my $local_part = shift;
	die "USAGE: AdvancedFiltering::DB::smtp::delete_mailbox<realm><client><domain><local_part>" unless defined($realm) && defined($client) && defined($domain) && defined($local_part);
	delete_ldap_object($_) foreach reverse find_ldap_value("afUSMTPDMBLocalPart=$local_part,afUSMTPDomainName=$domain,afUClientName=$client,afUServiceName=smtp+afUServiceRealm=$realm,ou=user,o=advancedfiltering", { objectClass => '*' }, 'dn');
	return 0;
}

1;
