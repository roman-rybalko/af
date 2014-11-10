package AdvancedFiltering::MailBox::submission::Add;

use strict;
use warnings;

use AdvancedFiltering::DB::submission qw(get_mailbox_data delete_mailbox);

sub run
{
	my $mailbox = shift;
	my $data = get_mailbox_data($mailbox);
	return "mailbox data is not found" unless $data;
	$data->{update_time} = time;
	delete_mailbox($data);
	return 0;
}

1;
