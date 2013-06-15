#!/usr/bin/perl

use strict;
use warnings;
use IO::Socket::INET;
use IO::Socket::SSL;
use Getopt::Std;

my %opts;

getopt('t', \%opts);

exit(0) if $opts{'t'};
