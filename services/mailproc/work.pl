#!/usr/bin/perl

use strict;
use warnings;

use Getopt::Std;
use Mail::SpamAssassin;
use Net::LDAP;

my %opts;
getopts('h', \%opts);

if ($opts{h})
{
	print "USAGE: $0 [options]\n",
		"OPTIONS:\n",
		"\t-h\tThis help screen\n",
		"";
	exit 0;
}
