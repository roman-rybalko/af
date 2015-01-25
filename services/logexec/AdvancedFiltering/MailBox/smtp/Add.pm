package AdvancedFiltering::MailBox::smtp::Add;

use strict;
use warnings;

use AdvancedFiltering::DB::smtp qw(get_mailbox_data add_mailbox update_mailbox);

sub run
{
	my $mailbox = shift;
	die "USAGE: <mailbox>" unless defined($mailbox);
	my $data = get_mailbox_data($mailbox);
	return "mailbox data is not found" unless $data;
	return update_mailbox($data->{realm}, $data->{client}, $data->{domain}, $data->{local_part}, 0) if defined $data->{local_part};
	my ($local_part) = split /@/, $mailbox;
	die "mailbox parse failed" unless defined $local_part;
	return add_mailbox($data->{realm}, $data->{client}, $data->{domain}, $local_part);
}

1;
