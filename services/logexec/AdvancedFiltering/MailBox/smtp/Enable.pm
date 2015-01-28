package AdvancedFiltering::MailBox::smtp::Enable;

use strict;
use warnings;

use AdvancedFiltering::DB::smtp qw(get_mailbox_data add_mailbox update_mailbox);

sub run
{
	my $mailbox = shift;
	die "USAGE: <mailbox>" unless defined $mailbox;
	my $data = get_mailbox_data($mailbox);
	return "mailbox data is not found" unless $data;
	return update_mailbox($data->{realm}, $data->{client}, $data->{domain}, $data->{local_part}, 0) if defined $data->{update_time};
	return add_mailbox($data->{realm}, $data->{client}, $data->{domain}, $data->{local_part});
}

1;
