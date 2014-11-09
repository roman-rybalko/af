package AdvancedFiltering::LDAP;

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(get_ldap_value find_ldap_value add_ldap_object update_ldap_object);

use Net::LDAP;
use AdvancedFiltering::Conf qw(get_conf_value);

my $ldap;
sub init_ldap
{
	die 'LDAP: ldap_url conf.option is required' unless get_conf_value('ldap_url');
	$ldap = Net::LDAP->new($opts{U}) or die "LDAP connection error";
	if (get_conf_value('ldap_tls_cert'))
	{
		die 'LDAP: ldap_tls_key conf.option option is required' unless get_conf_value('ldap_tls_key');
		my @options = (
			clientcert => get_conf_value('ldap_tls_cert'),
			clientkey => get_conf_value('ldap_tls_key'),
		);
		push @options =>
			verify => 'require',
			capath => get_conf_value('ldap_tls_ca'),
			checkcrl => 1
				if get_conf_value('ldap_tls_ca');
		my $ldap_msg = $ldap->start_tls(@options);
		die "LDAP: start_tls failed: " . $ldap_msg->error_text if $ldap_msg->is_error;
	}
	if (get_conf_value('ldap_bind_dn'))
	{
		die "LDAP: ldap_bind_pw conf.option is required" unless get_conf_value('ldap_bind_pw');
		my $ldap_msg = $ldap->bind(get_conf_value('ldap_bind_dn'), password => get_conf_value('ldap_bind_pw'));
		die "LDAP: bind failed: " . $ldap_msg->error_text if $ldap_msg->is_error;
	}
}

sub get_ldap_value
{
	my $dn = shift;
	my $attrs = shift;
	init_ldap unless $ldap;
	my $ldap_msg = $ldap->search(
		base => $dn,
		scope => 'base',
		filter => '(objectClass=*)',
		attrs => ref($attrs) ? $attrs : [$attrs],
	);
	die "LDAP: search failed: " . $ldap_msg->error_text if $ldap_msg->is_error;
	my @entries = $ldap_msg->entries;
	return wantarray?():undef unless @entries;
	my $entry = $entries[0];
	if (ref $attrs)
	{
		my $result = {};
		%$result = map { $_ => $entry->get_value($_) } @$attrs;
		return ($result) if wantarray;
		return $result;
	}
	else
	{
		return $entry->get_value($attrs);
	}
}

sub find_ldap_value
{
	my $dn = shift;
	my $filter = shift;
	my $attrs = shift;	
	init_ldap unless $ldap;
	my $filter_str = '';
	if ($filter)
	{
		$filter_str .= "($_=$filter->{$_})" foreach keys %$filter;
		$filter_str = "(\&$filter_str)";
	}
	else
	{
		$filter_str = '(objectClass=*)';
	}
	my $ldap_msg = $ldap->search(
		base => $dn,
		scope => 'sub',
		filter => $filter_str,
		attrs => ref($attrs) ? $attrs : [$attrs],
	);
	die "LDAP: search failed: " . $ldap_msg->error_text if $ldap_msg->is_error;
	my @entries = $ldap_msg->entries;
	return wantarray?():undef unless @entries;
	if (ref $attrs)
	{
		if (wantarray)
		{
			my $result2 = [];
			foreach my $entry (@entries)
			{
				my $result = {};
				%$result = map { $_ => $entry->get_value($_) } @$attrs;
				push @$result2 => $result;
			}
			return $result2;
		}
		else
		{
			my $result = {};
			%$result = map { $_ => $entries[0]->get_value($_) } @$attrs;
			return $result;
		}
	}
	else
	{
		return map { my @data = $_->get_value($attrs); } @entries if wantarray;
		return $entries[0]->get_value($attrs);
	}
}

sub add_ldap_object
{
	my $dn = shift;
	my $attrs = shift;
	init_ldap unless $ldap;
	my $ldap_msg = $ldap->add($dn, attr => [%$attrs]);
	if ($ldap_msg->is_error)
	{
		$ldap_msg = $ldap->search(
			base => $dn,
			scope => 'base',
			filter => '(objectClass=*)',
			attrs => [%$attrs],
		);
		die "LDAP: add/search failed: " . $ldap_msg->error_text if $ldap_msg->is_error;
		return "already exists";
	}
	else
	{
		return 0;
	}
}

1;
