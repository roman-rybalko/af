#!/usr/bin/perl

use strict;
use warnings;

use MIME::Base64;

my $mid = $ARGV[0];
$mid =~ tr~\.\-_~/\+=~;
$mid = decode_base64($mid);

print "$mid\n";