#!/usr/bin/perl

use strict;
use warnings;

use MIME::Base64;

my $mid_list = join(" ", @ARGV);

$mid_list =~ s/>[^<>]*</ /g;
$mid_list =~ s/^[^<]*</ /;
$mid_list =~ s/>[^>]*$/ /;

$mid_list =~ s/^\s+//;
$mid_list =~ s/\s+$//;
my @mid_list = split(/\s+/, $mid_list);
foreach (@mid_list)
{
	$_ = encode_base64($_, '');
	tr~/\+=~\.\-_~;
}

exit 1 unless @mid_list;

print join(":", @mid_list);
exit 0;
