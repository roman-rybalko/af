package AdvancedFiltering::MessageID::smtpdb::Add;

use strict;
use warnings;

use AdvancedFiltering::DB::smtpdb qw(add_message);

sub run
{
	my $realm = shift;
	my $mid = shift;
	my $sender = shift;
	my $spam_descr = shift;
	die "USAGE: <realm> <message-id> <sender> [spam_descr]" unless defined($realm) && defined($mid) && defined($sender);
	return "message-id is missing" unless $mid;
	return add_message(realm => $realm, mid => $mid, sender => $sender, defined($spam_descr) ? (spam_descr => $spam_descr) : ());
}

1;
