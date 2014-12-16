package AdvancedFiltering::MailBox::Check;

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(check_mailbox_vrfy check_mailbox_rcpt);

use AdvancedFiltering::SMTP;
use AdvancedFiltering::Conf qw(get_conf_value);

# params:
# host - host:port
# mailbox
# tls_cert
# tls_key
# tls_ca
# timeout
# return:
# 0 -OK
# str - FAIL
sub check_mailbox_vrfy
{
	my %params = @_;
	my $smtp = AdvancedFiltering::SMTP->new(
		$params{host},
		Timeout => $params{timeout},
		Hello => `hostname`,
		Debug => get_conf_value('check_mailbox_vrfy_smtp_debug'),
	) or die "Can't connect to SMTP server";
	if ($params{tls_cert} && $params{tls_key})
	{
		my @options = (SSL_cert_file => $params{tls_cert}, SSL_key_file => $params{tls_key});
		push @options => $params{tls_ca} ? (SSL_ca_path => $params{tls_ca}, SSL_check_crl => 1, SSL_verify_mode => 0x01) : (SSL_verify_mode => 0x00);
		$smtp->starttls(@options) or die "STARTTLS failed (", IO::Socket::SSL::errstr, ")";
	}
	my $result = 0;
	$smtp->verify($params{mailbox});
	die $smtp->code . " " . $smtp->message if $smtp->code == 252 || $smtp->status == 4;
	$result = $smtp->message unless $smtp->ok;
	$smtp->quit;
	if ($params{tls_cert} && $params{tls_key})
	{
		$smtp->stoptls;
	}
	return $result;
}

sub check_mailbox_rcpt
{
	my %params = @_;
	return "TODO";
}

1;
