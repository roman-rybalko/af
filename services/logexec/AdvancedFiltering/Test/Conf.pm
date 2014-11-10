package AdvancedFiltering::Test::Conf;

use strict;
use warnings;

use AdvancedFiltering::Conf qw(get_conf_value);

sub run
{
	my $name = shift;
	return get_conf_value($name);
}

1;
