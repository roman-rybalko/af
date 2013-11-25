#!/usr/bin/perl
use Storable;
my $data = {
mailbox => 'absent',
domain => 'test.com',
client => 'cli1',
realm => 'r1',
};
store $data, '.tasks/r1-cli1-test.com-absent';
