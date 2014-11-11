#!/usr/bin/perl

use strict;
use warnings;
$| = 1;

my $ok;
my $fail;
my $fatal;
my $total;

sub reset_counters
{
	$ok = $ENV{TESTPROC_OK} || 0;
	$fail = $ENV{TESTPROC_FAIL} || 0;
	$fatal = $ENV{TESTPROC_FATAL} || 0;
	$total = $ok + $fail + $fatal;
}

my $L;
open $L, ">", "testproc.log" or die "Unable to open log";

while (<>)
{
	print $L $_;
	reset_counters unless $total;
	if ($ok)
	{
		print "OK\n";
		--$ok;
	}
	elsif ($fail)
	{
		print "FAIL: $fail\n";
		--$fail;
	}
	elsif ($fatal)
	{
		print "FATAL: $fatal\n";
		--$fatal;
	}
	else
	{
		print "TOTAL: $total\n";
	}
	--$total;
}
