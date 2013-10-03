#!/usr/bin/perl

use strict;
use warnings;

use Mail::SpamAssassin;
use MIME::Base64;

my $file = $ARGV[0];
my $mid;
my $F;
if (open $F, "<", $file)
{
	my $sa = Mail::SpamAssassin->new({dont_copy_prefs => 1, local_tests_only => 1});
	my $mime = $sa->parse($F);
	my $hdr = $mime->get_pristine_header("message-id");
	die "No Message-Id header" unless $hdr;
	$hdr =~ s/^\s+//;
	$hdr =~ s/\s+$//;
	$mid = $hdr;
}
else
{
	$mid = $file;
}

$mid = encode_base64($mid, '');
$mid =~ tr~/\+=~\.\-_~;

print "$mid\n";