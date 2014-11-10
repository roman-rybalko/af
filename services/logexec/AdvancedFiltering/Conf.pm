package AdvancedFiltering::Conf;

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(get_conf_value);

my %conf;
sub init_conf
{
	# init
	$conf{hostname} = `hostname`;
	$conf{hostname} =~ s/\s//g;
	$conf{private_tls_cert} = '/etc/advancedfiltering_ssl/'.$conf{hostname}.'.crt';
	$conf{private_tls_key} = '/etc/advancedfiltering_ssl/'.$conf{hostname}.'.key';
	$conf{private_tls_ca} = '/etc/advancedfiltering_ssl/ca';
	$conf{private_tls_crl} = $conf{private_tls_ca};
	$conf{public_tls_ca} = '/usr/local/advancedfiltering/ssl/ca';
	$conf{public_tls_crl} = $conf{public_tls_ca};
	$conf{ldap_tls_cert} = $conf{private_tls_cert};
	$conf{ldap_tls_key} = $conf{private_tls_key};
	$conf{ldap_tls_ca} = $conf{private_tls_ca};
	$conf{ldap_tls_crl} = $conf{private_tls_crl};
	$conf{ldap2_tls_cert} = $conf{private_tls_cert};
	$conf{ldap2_tls_key} = $conf{private_tls_key};
	$conf{ldap2_tls_ca} = $conf{private_tls_ca};
	$conf{ldap2_tls_crl} = $conf{private_tls_crl};

	# init from env
	foreach my $key (keys %ENV)
	{
		my $name = $key;
		if ($name =~ s/^ADVANCEDFILTERING_//i || $name =~ s/^AF_//i)
		{
			$conf{lc $name} = $ENV{$key};
			next;
		}
	}
}

sub get_conf_value
{
	my $name = shift;
	init_conf unless %conf;
	return $conf{$name};
}

1;
