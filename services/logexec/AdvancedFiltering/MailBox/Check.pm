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
	$smtp->starttls(
		SSL_cert_file => $params{tls_cert},
		SSL_key_file => $params{tls_key},
		SSL_ca_path => $params{tls_ca},
		SSL_check_crl => 1,
		SSL_verify_mode => 0x01,
	) or die "STARTTLS failed (", IO::Socket::SSL::errstr, ")";
	my $result = $smtp->verify($params{mailbox}) ? 0 : $smtp->message;
	$smtp->quit;
	return $result;
}

sub check_mailbox_rcpt
{
	my %params = @_;
	return "TODO";
	
	
	my $mbox_settings = shift;
	my $mx1_settings = shift;
	my $smtp = AdvancedFiltering::SMTP->new(
		$mx1_settings->{afUSMTPMXHostName},
		Port => $mx1_settings->{afUSMTPMXTCPPort},
		Timeout => $opts{T},
		Hello => `hostname`,
	) or die "Can't connect to SMTP server";
	warn "MX settings: ", Dumper($mx1_settings) if $opts{v} > 1;
	die "STARTTLS is not supported but required"
		if $mx1_settings->{afUSMTPMXTLSRequired}
		&& !defined($smtp->supports('STARTTLS'));
	die "AUTH CRAM-MD5 & STARTTLS is not supported but AUTH is required"
		if $mx1_settings->{afUSMTPMXAuthUser}
		&& (!defined($smtp->supports('AUTH')) || $smtp->supports('AUTH') !~ /CRAM\-MD5/)
		&& !defined($smtp->supports('STARTTLS'));
	if (defined $smtp->supports('STARTTLS'))
	{
		my %args;
		$args{SSL_cert_file} = "$opts{S}/$mx1_settings->{afUSMTPMXAuthTLSCertificate}.crt" if $mx1_settings->{afUSMTPMXAuthTLSCertificate};
		$args{SSL_key_file} = "$opts{S}/$mx1_settings->{afUSMTPMXAuthTLSKey}.key" if $mx1_settings->{afUSMTPMXAuthTLSKey};
		if ($mx1_settings->{afUSMTPMXAuthTLSCA})
		{
			$args{SSL_ca_path} = "$opts{S}/$mx1_settings->{afUSMTPMXAuthTLSCA}";
			$args{SSL_check_crl} = 1;
			$args{SSL_verify_mode} = 0x01;
		}
		else
		{
			$args{SSL_verify_mode} = 0x00;
		}
		warn "STARTTLS args: ", Dumper(\%args) if $opts{v} > 1;
		$smtp->starttls(%args) or die "STARTTLS failed (", IO::Socket::SSL::errstr, ")";
		$smtp->hello(`hostname`) or die "EHLO/HELO failed";
	}
	die "AUTH is not supported but required"
		if $mx1_settings->{afUSMTPMXAuthUser}
		&& !defined($smtp->supports('AUTH'));
	if ($mx1_settings->{afUSMTPMXAuthUser})
	{
		$smtp->auth($mx1_settings->{afUSMTPMXAuthUser}, $mx1_settings->{afUSMTPMXAuthPassword}) or die "AUTH failed";
	}
	$smtp->mail($opts{f}) or die "MAIL failed";
	my $existing = $smtp->to("$mbox_settings->{mailbox}\@$mbox_settings->{domain}");
	$smtp->quit();
	return $existing;
}

1;
