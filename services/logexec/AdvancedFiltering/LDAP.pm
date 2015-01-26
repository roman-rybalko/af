package AdvancedFiltering::LDAP;

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(get_ldap_value find_ldap_value add_ldap_object update_ldap_object delete_ldap_object);

use Net::LDAP;
use AdvancedFiltering::Conf qw(get_conf_value check_conf_value);

my $ldap;
sub init_ldap
{
	$ldap = Net::LDAP->new(get_conf_value('ldap_url')) or die "LDAP connection error";
	if (check_conf_value('ldap_tls_cert'))
	{
		my @options;
		push @options => (clientcert => get_conf_value('ldap_tls_cert'), clientkey => get_conf_value('ldap_tls_key'), );
		push @options => (verify => 'require', capath => get_conf_value('ldap_tls_ca'), checkcrl => 1, ) if check_conf_value('ldap_tls_ca');
		my $msg = $ldap->start_tls(@options);
		die "AdvancedFiltering::LDAP::init_ldap: start_tls failed: " . $msg->error_text if $msg->is_error;
	}
	if (check_conf_value('ldap_bind_dn'))
	{
		my $msg = $ldap->bind(get_conf_value('ldap_bind_dn'), password => get_conf_value('ldap_bind_pw'));
		die "AdvancedFiltering::LDAP::init_ldap: bind failed: " . $msg->error_text if $msg->is_error;
	}
}

sub get_value
{
	my $entry = shift;
	my $attr = shift;
	die "USAGE: AdvancedFiltering::LDAP::get_value<entry><attr>" unless defined($entry) && defined($attr);
	if (lc($attr) eq 'dn')
	{
		return ($entry->dn) if wantarray;
		return $entry->dn;
	}
	return $entry->get_value($attr);
}

sub get_ldap_value
{
	my $dn = shift;
	my $attrs = shift;
	die "USAGE: AdvancedFiltering::LDAP::get_ldap_value<dn><attrs>" unless defined($dn) && defined($attrs);
	init_ldap unless $ldap;
	my $msg = $ldap->search(
		base => $dn,
		scope => 'base',
		filter => '(objectClass=*)',
		attrs => ref($attrs) ? $attrs : [$attrs],
	);
	my @entries = $msg->entries;
	return wantarray ? () : undef unless @entries;
	my $entry = $entries[0];
	if (ref $attrs)
	{
		my $result = {};
		$result->{$_} = get_value($entry, $_) foreach @$attrs;
		return ($result) if wantarray;
		return $result;
	}
	else
	{
		return get_value($entry, $attrs);
	}
}

sub find_ldap_value
{
	my $dn = shift;
	my $filter = shift;
	my $attrs = shift;	
	die "USAGE: AdvancedFiltering::LDAP::find_ldap_value<dn><filter><attrs>" unless defined($dn) && defined($filter) && defined($attrs);
	init_ldap unless $ldap;
	my $filter_str = '';
	if ($filter)
	{
		$filter_str .= "($_=$filter->{$_})" foreach keys %$filter;
		$filter_str = "(\&$filter_str)" if scalar(keys %$filter) > 1;
	}
	else
	{
		$filter_str = '(objectClass=*)';
	}
	my $msg = $ldap->search(
		base => $dn,
		scope => 'sub',
		filter => $filter_str,
		attrs => ref($attrs) ? $attrs : [$attrs],
	);
	my @entries = $msg->entries;
	return wantarray ? () : undef unless @entries;
	if (ref $attrs)
	{
		if (wantarray)
		{
			my $result2 = [];
			foreach my $entry (@entries)
			{
				my $result = {};
				$result->{$_} = get_value($entry, $_) foreach @$attrs;
				push @$result2 => $result;
			}
			return $result2;
		}
		else
		{
			my $result = {};
			$result->{$_} = get_value($entries[0], $_) foreach @$attrs;
			return $result;
		}
	}
	else
	{
		return map { my @data = get_value($_, $attrs); } @entries if wantarray;
		return get_value($entries[0], $attrs);
	}
}

sub add_ldap_object
{
	my $dn = shift;
	my $attrs = shift;
	die "USAGE: AdvancedFiltering::LDAP::add_ldap_object<dn><attrs>" unless defined($dn) && defined($attrs);
	init_ldap unless $ldap;
	my $msg = $ldap->add($dn, attr => [%$attrs]);
	if ($msg->is_error)
	{
		my $msg2 = $ldap->search(
			base => $dn,
			scope => 'base',
			filter => '(objectClass=*)',
			attrs => [%$attrs],
		);
		die "AdvancedFiltering::LDAP::add_ldap_object: add failed: " . $msg->error_text . "; search failed: " . $msg2->error_text if $msg2->is_error;
		return "already exists";
	}
	else
	{
		return 0;
	}
}

sub update_ldap_object
{
	my $dn = shift;
	my $attrs = shift;
	die "USAGE: AdvancedFiltering::LDAP::update_ldap_object<dn><attrs>" unless defined($dn) && defined($attrs);
	init_ldap unless $ldap;
	my $msg = $ldap->search(
		base => $dn,
		scope => 'base',
		filter => '(objectClass=*)',
		attrs => [%$attrs],
	);
	my @entries = $msg->entries;
	return "not found" unless @entries;
	my $entry = $entries[0];
	$entry->replace(%$attrs);
	$msg = $entry->update($ldap);
	die "AdvancedFiltering::LDAP::update_ldap_object: update/update failed: " . $msg->error_text if $msg->is_error;
	return 0;
}

sub delete_ldap_object
{
	my $dn = shift;
	die "USAGE: AdvancedFiltering::LDAP::delete_ldap_object<dn>" unless defined($dn);
	init_ldap unless $ldap;
	my $msg = $ldap->search(
		base => $dn,
		scope => 'base',
		filter => '(objectClass=*)',
		attrs => ['dn'],
	);
	my @entries = $msg->entries;
	return "not found" unless @entries;
	my $entry = $entries[0];
	$entry->delete;
	$msg = $entry->update($ldap);
	die "AdvancedFiltering::LDAP::delete_ldap_object: delete/update failed: " . $msg->error_text if $msg->is_error;
	return 0;
}

1;
