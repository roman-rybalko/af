package AdvancedFiltering::MessageID::submissiondb::Delete;

use strict;
use warnings;

use AdvancedFiltering::DB::submissiondb qw(delete_message);

sub run
{
	my $realm = shift;
	my $mid = shift;
	die "USAGE: <realm> <message-id>" unless $realm && $mid;
	delete_message($realm, $mid);
	return 0;
}

1;
