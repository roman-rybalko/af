package AdvancedFiltering::MailBox::Check::AFsmtp;

use strict;
use warnings;

use List::Util qw(shuffle);

use AdvancedFiltering::DB qw(get_service_hosts);
use AdvancedFiltering::DB::submission qw(get_mailbox_data);
use AdvancedFiltering::MailBox::Check qw(check_mailbox_vrfy);
use AdvancedFiltering::Conf qw(get_conf_value check_conf_value);

#
# conf:
# afsmtp_vrfy_timeout
#
sub run
{
	my $mailbox = shift;
	die "USAGE: <mailbox>" unless $mailbox;
	my $data = get_mailbox_data($mailbox);
	return "mailbox data is not found" unless $data;
	my @hosts = get_service_hosts($data->{realm}, 'smtp');
	@hosts = shuffle(@hosts);
	my @errors;
	foreach my $host (@hosts)
	{
		my $result = eval {
			check_mailbox_vrfy(
				host => $host,
				mailbox => $data->{local_part}.'@'.$data->{domain},
				check_conf_value('private_tls_cert') ? (tls_cert => get_conf_value('private_tls_cert'), tls_key => get_conf_value('private_tls_key'), ) : (),
				check_conf_value('private_tls_ca') ? (tls_ca => get_conf_value('private_tls_ca'), ) : (),
				timeout => check_conf_value('afsmtp_vrfy_timeout') ? get_conf_value('afsmtp_vrfy_timeout') : 10,
			);
		};
		if ($@)
		{
			push @errors => "$host: $@";
			next;
		}
		return $result;
	}
	die "no smtp hosts available (" . join(",", @errors) . ")";
}

1;
