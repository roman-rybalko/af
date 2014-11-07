package AdvancedFiltering::MailBox::Check::AFsmtp;

use strict;
use warnings;

use AdvancedFiltering::DB qw(get_mailbox_submission_info get_service_hosts);
use AdvancedFiltering::MailBox::Check qw(check_mailbox_vrfy);
use AdvancedFiltering::Conf qw(get_conf_value);

# ENV
# AF_VRFY_TIMEOUT

sub run
{
	my $mailbox = shift;
	my $info = get_mailbox_submission_info($mailbox);
	return "mailbox data is not found" unless $info;
	my @hosts = get_service_hosts($info->{realm}, 'smtp');
	my $service_cert = get_conf_value("");
	foreach my $host (@hosts)
	{
		my $result = eval {
			check_mailbox_vrfy(
				host => $host,
				mailbox => $info->{local_part}.'@'.$info->{domain},
				tls_cert => get_conf_value('private_tls_cert'),
				tls_key => get_conf_value('private_tls_key'),
				tls_ca => get_conf_value('private_tls_ca'),
				timeout => get_conf_value('vrfy_timeout') || 10,
			);
		};
		next if $@;
		return $result;
	}
	return "no smtp hosts available";
}

1;
