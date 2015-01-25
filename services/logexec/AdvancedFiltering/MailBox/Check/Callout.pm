package AdvancedFiltering::MailBox::Check::Callout;

use strict;
use warnings;

use List::Util qw(shuffle);

use AdvancedFiltering::DB::smtp qw(get_mailbox_data get_mx_data);
use AdvancedFiltering::MailBox::Check qw(check_mailbox_rcpt);
use AdvancedFiltering::Conf qw(get_conf_value);

#
# conf:
# callout_rcpt_timeout
# callout_tls_data_path
#
sub run
{
	my $mailbox = shift;
	die "USAGE: <mailbox>" unless defined($mailbox);
	my $mb_data = get_mailbox_data($mailbox);
	return "mailbox data is not found" unless $mb_data;
	my @mx_data = get_mx_data($mb_data->{realm}, $mb_data->{client}, $mb_data->{domain}, $mb_data->{local_part});
	return "mx data is not found" unless @mx_data;
	@mx_data = shuffle(@mx_data);
	my @errors;
	foreach my $mx_data (@mx_data)
	{
		my $result = eval {
			check_mailbox_rcpt(
				host => $mx_data->{host},
				mailbox => $mailbox,
				$mx_data->{auth_user} ? (auth_user => $mx_data->{auth_user}, auth_password => $mx_data->{auth_password}) : (),
				$mx_data->{tls_required} ? (tls_required => $mx_data->{tls_required}) : (),
				$mx_data->{tls_cert_name} ? (tls_cert => get_conf_value('callout_tls_data_path').'/'.$mx_data->{tls_cert_name}.'.crt', tls_key => get_conf_value('callout_tls_data_path').'/'.$mx_data->{tls_key_name}.'.key') : (),
				$mx_data->{tls_ca_name} ? (tls_ca => get_conf_value('callout_tls_data_path').'/'.$mx_data->{tls_ca_name}) : (),
				timeout => get_conf_value('callout_rcpt_timeout') || 10,
			);
		};
		if ($@)
		{
			push @errors => "$mx_data->{host}: $@";
			next;
		}
		return $result;
	}
	die "no smtp hosts available (" . join(",", @errors) . ")";
}

1;
