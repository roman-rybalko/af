package AdvancedFiltering::MessageID::smtpdb::Delete;

use strict;
use warnings;

use AdvancedFiltering::DB::smtpdb qw(delete_message);

sub run
{
	my $realm = shift;
	my $mid = shift;
	die "USAGE: <realm> <message-id>" unless defined($realm) && defined($mid);
	return "message-id is missing" unless $mid;
	return delete_message($realm, $mid);
}

1;
