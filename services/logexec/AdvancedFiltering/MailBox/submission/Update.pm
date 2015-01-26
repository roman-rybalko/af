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
	return "mailbox has not been created" unless defined $data->{update_time};
	return update_mailbox($data->{realm}, $data->{client}, $data->{domain}, $data->{local_part});
}

1;
