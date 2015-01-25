package AdvancedFiltering::MessageID::submissiondb::Add;

use strict;
use warnings;

use AdvancedFiltering::DB::submissiondb qw(add_message);

sub run
{
	my $realm = shift;
	my $mid = shift;
	my $sender = shift;
	die "USAGE: <realm> <message-id> <sender>" unless defined($realm) && defined($mid) && defined($sender);
	return "message-id is missing" unless $mid;
	return add_message($realm, $mid, $sender);
}

1;
