package AdvancedFiltering::MailBox::smtp::Disable;

use strict;
use warnings;

use AdvancedFiltering::DB::smtp qw(get_mailbox_data update_mailbox);

sub run
{
	my $mailbox = shift;
	die "USAGE: <mailbox>" unless $mailbox;
	my $data = get_mailbox_data($mailbox);
	return "mailbox data is not found" unless $data;
	return "mailbox has been not yet created" unless defined $data->{local_part};
	return update_mailbox(realm => $data->{realm}, client => $data->{client}, domain => $data->{domain}, local_part => $data->{local_part}, update_time => time, absent => 1);
}

1;
