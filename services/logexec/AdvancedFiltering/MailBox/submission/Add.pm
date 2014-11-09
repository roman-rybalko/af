package AdvancedFiltering::MailBox::submission::Add;

use strict;
use warnings;

use AdvancedFiltering::DB::submission qw(get_mailbox_info add_mailbox);

sub run
{
	my $mailbox = shift;
	my $info = get_mailbox_info($mailbox);
	return "mailbox data is not found" unless $info;
	$info->{update_time} = time;
	add_mailbox($info);
	return 0;
}

1;
