package AdvancedFiltering::MessageID::submissiondb::Add;

use strict;
use warnings;

use AdvancedFiltering::DB::submissiondb qw(add_messageid);

sub run
{
	my $realm = shift;
	my $mid = shift;
	my $sender = shift;
	add_messageid($realm, $mid, $sender);
	return 0;
}

1;
