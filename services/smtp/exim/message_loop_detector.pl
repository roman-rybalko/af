#!/usr/bin/perl

use strict;
use warnings;

for (my $i = 2; $i <= scalar(@ARGV); $i+=2)
{
	if (lc(join(" ", @ARGV[0..($i/2-1)])) eq lc(join(" ", @ARGV[($i/2)..($i-1)])))
	{
		print "[", lc(join(" -> ", @ARGV[0..($i/2-1)])), "], [", lc(join(" -> ", @ARGV[($i/2)..($i-1)])), "]\n";
		exit 0;
	}
}
exit 1;
