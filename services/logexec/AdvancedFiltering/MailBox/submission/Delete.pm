package AdvancedFiltering::MailBox::submission::Delete;

use strict;
use warnings;

use AdvancedFiltering::DB::submission qw(get_mailbox_data delete_mailbox);

sub run
{
	my $mailbox = shift;
	die "USAGE: <mailbox>" unless defined($mailbox);
	my $data = get_mailbox_data($mailbox);
	return "mailbox data is not found" unless $data;
	return delete_mailbox($data->{realm}, $data->{client}, $data->{domain}, $data->{local_part});
}

1;
