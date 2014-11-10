package AdvancedFiltering::MailBox::submission::Add;

use strict;
use warnings;

use AdvancedFiltering::DB::submission qw(get_mailbox_data add_mailbox);

sub run
{
	my $mailbox = shift;
	die "USAGE: <mailbox>" unless $mailbox;
	my $data = get_mailbox_data($mailbox);
	return "mailbox data is not found" unless $data;
	$data->{update_time} = time;
	add_mailbox($data);
	return 0;
}

1;
