package AdvancedFiltering::MessageID::smtpdb::Add;

use strict;
use warnings;

use AdvancedFiltering::DB::smtpdb qw(add_message);

sub run
{
	my $realm = shift;
	my $mid = shift;
	my $sender = shift;
	die "USAGE: <realm> <message-id> <sender>" unless defined($realm) && defined($mid) && defined($sender);
	return add_message(realm => $realm, mid => $mid, sender=> $sender);
}

1;
