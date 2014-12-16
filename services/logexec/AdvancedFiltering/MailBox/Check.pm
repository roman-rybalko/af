package AdvancedFiltering::MailBox::Check;

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(check_mailbox_vrfy check_mailbox_rcpt);

use AdvancedFiltering::SMTP;

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
	) or die "Can't connect to SMTP server";
	if ($params{tls_cert} && $params{tls_key})
	{
		my @options = (SSL_cert_file => $params{tls_cert}, SSL_key_file => $params{tls_key});
		push @options => $params{tls_ca} ? (SSL_ca_path => $params{tls_ca}, SSL_check_crl => 1, SSL_verify_mode => 0x01) : (SSL_verify_mode => 0x00);
		$smtp->starttls(@options) or die "STARTTLS failed (", IO::Socket::SSL::errstr, ")";
	}
	my $result = $smtp->verify($params{mailbox}) ? 0 : $smtp->message;
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
