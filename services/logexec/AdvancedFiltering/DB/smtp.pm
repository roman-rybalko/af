package AdvancedFiltering::DB::smtp;

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(get_domain_client get_mailbox_data get_mx_data add_mailbox update_mailbox);

use AdvancedFiltering::DB qw(get_my_realms get_client_realm);
use AdvancedFiltering::LDAP qw(get_ldap_value add_ldap_object update_ldap_object);

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
		$data ? (local_part => $local_part, update_time => $data->{afUSMTPDMBTimeUpdated}, is_absent => $data->{afUSMTPDMBIsAbsent}) : (),
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
	my %params = @_;
	my @ldap_dn;
	if (defined $params{realm} && defined $params{client})
	{
		unshift @ldap_dn => "afUClientName=$params{client},afUServiceName=smtp+afUServiceRealm=$params{realm},ou=user,o=advancedfiltering";
		if (defined $params{domain})
		{
			unshift @ldap_dn => "afUSMTPDomainName=$params{domain},afUClientName=$params{client},afUServiceName=smtp+afUServiceRealm=$params{realm},ou=user,o=advancedfiltering";
			if (defined $params{local_part})
			{
				unshift @ldap_dn => "afUSMTPDMBLocalPart=$params{local_part},afUSMTPDomainName=$params{domain},afUClientName=$params{client},afUServiceName=smtp+afUServiceRealm=$params{realm},ou=user,o=advancedfiltering";
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
	my %params = @_;
	return add_ldap_object("afUSMTPDMBLocalPart=$params{local_part},afUSMTPDomainName=$params{domain},afUClientName=$params{client},afUServiceName=smtp+afUServiceRealm=$params{realm},ou=user,o=advancedfiltering",
		{objectClass => 'afUSMTPDMailBox', afUSMTPDMBTimeUpdated => time, });
}

sub update_mailbox
{
	my %params = @_;
	return update_ldap_object("afUSubmissionDMBLocalPart=$params{local_part},afUSubmissionDomainName=$params{domain},afUClientName=$params{client},afUServiceName=smtp+afUServiceRealm=$params{realm},ou=user,o=advancedfiltering",
		{afUSMTPDMBTimeUpdated => $params{update_time}, defined($params{absent}) ? (afUSMTPDMBIsAbsent => $params{absent} ? 'TRUE' : []) : (), });
}

1;
