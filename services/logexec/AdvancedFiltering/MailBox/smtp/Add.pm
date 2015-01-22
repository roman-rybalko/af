package AdvancedFiltering::MailBox::smtp::Add;

use strict;
use warnings;

use AdvancedFiltering::DB::smtp qw(get_mailbox_data add_mailbox update_mailbox);

sub run
{
	my $mailbox = shift;
	die "USAGE: <mailbox>" unless $mailbox;
	my $data = get_mailbox_data($mailbox);
	return "mailbox data is not found" unless $data;
	return update_mailbox(realm => $data->{realm}, client => $data->{client}, domain => $data->{domain}, local_part => $data->{local_part}, update_time => time, absent => 0) if defined $data->{local_part};
	my ($local_part) = split /@/, $mailbox;
	return add_mailbox(realm => $data->{realm}, client => $data->{client}, domain => $data->{domain}, local_part => $local_part);
}

1;
