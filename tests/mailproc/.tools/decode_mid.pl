#!/usr/bin/perl

use strict;
use warnings;

use MIME::Base64;

my $mid = $ARGV[0];
my @mid_list = split(/:/, $mid);
foreach $mid (@mid_list)
{
	$mid =~ tr~\.\-_~/\+=~;
	$mid = decode_base64($mid);
	print "$mid\n";	
}