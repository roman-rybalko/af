package AdvancedFiltering::MailBox::submission::Update;

use strict;
use warnings;

use AdvancedFiltering::DB::submission qw(get_mailbox_data update_mailbox);

sub run
{
	my $mailbox = shift;
	die "USAGE: <mailbox>" unless $mailbox;
	my $data = get_mailbox_data($mailbox);
	return "mailbox data is not found" unless $data;
	$data->{update_time} = time;
	update_mailbox($data);
	return 0;
}

1;
