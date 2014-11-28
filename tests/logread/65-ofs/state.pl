#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

my $F;
open $F, "<", $ARGV[0] or die "Unable to open file $ARGV[0]: $!";
my @lines = <$F>;
my $data = join "", @lines;
no strict;
my $state = eval $data;
use strict;

print "state:\n" , Dumper($state);

exit 1 unless defined $state->{ofs} && $state->{ofs} == 0;

print "state: OK\n";
