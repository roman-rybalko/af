package AdvancedFiltering::Conf;

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(get_conf_value);

use FindBin;

my %conf;
sub init_defaults
{
	$conf{hostname} = `hostname`;
	$conf{hostname} =~ s/\s//g;
	$conf{private_tls_cert} = '/etc/advancedfiltering_ssl/'.$conf{hostname}.'.crt';
	$conf{private_tls_key} = '/etc/advancedfiltering_ssl/'.$conf{hostname}.'.key';
	$conf{private_tls_ca} = '/etc/advancedfiltering_ssl/ca';
	$conf{private_tls_crl} = $conf{private_tls_ca};
	$conf{public_tls_ca} = '/usr/local/advancedfiltering/ssl/ca';
	$conf{public_tls_crl} = $conf{public_tls_ca};
}
sub init_from_file
{
	my $F;
	my $confname = $FindBin::Script;
	$confname =~ s/\.pl$//;
	$confname .= '.conf';
	my $fname;
	open($F, '<', $fname = $FindBin::Bin . '/' . $confname) or open($F, '<', $fname = $FindBin::Bin . '/../' . $confname) or return;
	while (<$F>)
	{
		s/#.*$//;
		s/\s+$//;
		s/^\s+//;
		next unless $_;
		die "Conf: bad line: \"$_\" in file \"$fname\"" unless /=/;
		my ($name, $value) = split /\s*=\s*/, $_, 2;
		$value =~ s/^"//;
		$value =~ s/"$//;
		$value =~ s~^\./~$FindBin::Bin/~;
		$conf{lc $name} = $value;
	}
}
sub init_from_env
{
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
sub init_conf
{
	init_defaults;
	init_from_file;
	init_from_env;
}

sub get_conf_value
{
	my $name = shift;
	init_conf unless %conf;
	return $conf{$name};
}

1;
