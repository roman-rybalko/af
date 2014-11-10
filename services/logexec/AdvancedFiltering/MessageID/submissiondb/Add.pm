package AdvancedFiltering::MessageID::submissiondb::Add;

use strict;
use warnings;

use AdvancedFiltering::DB::submissiondb qw(add_message);

sub run
{
	my $realm = shift;
	my $mid = shift;
	my $sender = shift;
	die "USAGE: <realm> <message-id> <sender>" unless $realm && $mid && $sender;
	add_message($realm, $mid, $sender);
	return 0;
}

1;
