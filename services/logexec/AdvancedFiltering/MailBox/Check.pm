package AdvancedFiltering::MailBox::Check;

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(check_mailbox_vrfy check_mailbox_rcpt);

use AdvancedFiltering::SMTP;
use AdvancedFiltering::Conf qw(get_conf_value check_conf_value);

#
# params:
# host - host:port
# mailbox
# tls_cert
# tls_key
# tls_ca
# timeout
#
# conf:
# check_mailbox_vrfy_smtp_debug
#
# return:
# 0 -OK
# str - FAIL
#
sub check_mailbox_vrfy
{
	my %params = @_;
	die "USAGE: AdvancedFiltering::MailBox::Check::check_mailbox_vrfy<host => ...><timeout => ...><mailbox => ...>[<tls_cert => ...><tls_key => ...>[<tls_ca => ...>]]"
		if !defined($params{host})
		|| !defined($params{timeout})
		|| !defined($params{mailbox})
		|| (defined($params{tls_cert}) && !defined($params{tls_key}))
		|| (defined($params{tls_ca}) && !defined($params{tls_cert}));
	AdvancedFiltering::SMTP->init;
	my $smtp = AdvancedFiltering::SMTP->new(
		$params{host},
		Timeout => $params{timeout},
		Hello => `hostname`,
		Debug => check_conf_value('check_mailbox_vrfy_smtp_debug') ? get_conf_value('check_mailbox_vrfy_smtp_debug') : undef,
	) or die "Can't connect to SMTP server";
	if (defined $params{tls_cert})
	{
		my @options = (SSL_cert_file => $params{tls_cert}, SSL_key_file => $params{tls_key});
		push @options => defined($params{tls_ca}) ? (SSL_ca_path => $params{tls_ca}, SSL_check_crl => 1, SSL_verify_mode => 0x01) : (SSL_verify_mode => 0x00);
		$smtp->starttls(@options) or die "STARTTLS failed (", IO::Socket::SSL::errstr, ")";
	}
	my $result = 0;
	$smtp->verify($params{mailbox});
	die $smtp->code . " " . $smtp->message if $smtp->code == 252 || $smtp->status == 4;
	$result = $smtp->code . " " . $smtp->message unless $smtp->ok;
	$smtp->quit;
	return $result;
}

#
# params:
# host - host:port
# mailbox
# auth_user
# auth_password
# tls_required
# tls_cert
# tls_key
# tls_ca
# timeout
#
# conf:
# check_mailbox_rcpt_smtp_debug
# check_mailbox_rcpt_smtp_from
#
# return:
# 0 -OK
# str - FAIL
#
sub check_mailbox_rcpt
{
	my %params = @_;
	die "USAGE: AdvancedFiltering::MailBox::Check::check_mailbox_rcpt<host => ...><timeout => ...><mailbox => ...>[<tls_cert => ...><tls_key => ...>[<tls_ca => ...>]][<auth_user => ...><auth_password => ...>]"
		if !defined($params{host})
		|| !defined($params{timeout})
		|| !defined($params{mailbox})
		|| (defined($params{tls_cert}) && !defined($params{tls_key}))
		|| (defined($params{tls_ca}) && !defined($params{tls_cert}))
		|| (defined($params{auth_user}) && !defined($params{auth_password}));
	my $hello_hostname = `hostname`;
	AdvancedFiltering::SMTP->init;
	my $smtp = AdvancedFiltering::SMTP->new(
		$params{host},
		Timeout => $params{timeout},
		Hello => $hello_hostname,
		Debug => check_conf_value('check_mailbox_rcpt_smtp_debug') ? get_conf_value('check_mailbox_rcpt_smtp_debug') : undef,
	) or die "Can't connect to SMTP server";
	if (defined $smtp->supports('STARTTLS'))
	{
		my @options;
		push @options => defined($params{tls_cert}) ? (SSL_cert_file => $params{tls_cert}, SSL_key_file => $params{tls_key}) : ();
		push @options => defined($params{tls_ca}) ? (SSL_ca_path => $params{tls_ca}, SSL_check_crl => 1, SSL_verify_mode => 0x01) : (SSL_verify_mode => 0x00);
		if ($smtp->starttls(@options))
		{
			$smtp->hello($hello_hostname) or die "EHLO/HELO failed (second try; " . $smtp->code . " " . $smtp->message . ")";
		}
		else
		{
			die "STARTTLS failed (" . $smtp->code . " " . $smtp->message . "; " . IO::Socket::SSL::errstr . ") but requred" if $params{tls_required};
			$smtp->close;
			AdvancedFiltering::SMTP->init;
			$smtp = AdvancedFiltering::SMTP->new(
				$params{host},
				Timeout => $params{timeout},
				Hello => $hello_hostname,
				Debug => check_conf_value('check_mailbox_rcpt_smtp_debug') ? get_conf_value('check_mailbox_rcpt_smtp_debug') : undef,
			) or die "Can't connect to SMTP server (second try)";
		}
	}
	else
	{
		die "STARTTLS is not supported but required" if $params{tls_required};
	}
	if ($params{auth_user})
	{
		die "AUTH is not supported but required" unless defined $smtp->supports('AUTH');
		$smtp->auth($params{auth_user}, $params{auth_password}) or die "AUTH failed (" . $smtp->code . " " . $smtp->message . ")";
	}
	my $result = 0;
	$smtp->mail(check_conf_value('check_mailbox_rcpt_smtp_from') ? get_conf_value('check_mailbox_rcpt_smtp_from') : '<>');
	die $smtp->code . " " . $smtp->message if $smtp->status != 2;
	$smtp->to($params{mailbox});
	die $smtp->code . " " . $smtp->message if $smtp->status == 4;
	$result = $smtp->code . " " . $smtp->message unless $smtp->ok;
	$smtp->quit;
	return $result;
}

1;
