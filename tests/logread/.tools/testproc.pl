#!/usr/bin/perl

use strict;
use warnings;
use IO::Handle;

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
if ($ENV{TESTPROC_LOG})
{
	open $L, ">>", $ENV{TESTPROC_LOG} or die "Unable to open log";
	$L->autoflush(1);
}

STDOUT->autoflush(1);
while (<>)
{
	chomp;
	reset_counters unless $total;
	if ($ok)
	{
		print "OK\n";
		print $L "$_ -> OK\n" if $L;
		--$ok;
	}
	elsif ($fail)
	{
		print "FAIL: $fail\n";
		print $L "$_ -> FAIL: $fail\n" if $L;
		--$fail;
	}
	elsif ($fatal)
	{
		print "FATAL: $fatal\n";
		print $L "$_ -> FATAL: $fatal\n" if $L;
		--$fatal;
	}
	else
	{
		print "TOTAL: $total\n";
		print $L "$_ -> TOTAL: $total\n" if $L;
	}
	--$total;
}
