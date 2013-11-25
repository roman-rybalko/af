#!/usr/bin/perl

use strict;
use warnings;
use FindBin;
use lib ($FindBin::Bin);
use AdvancedFiltering::SMTP;

my $smtp = AdvancedFiltering::SMTP->new($ENV{AFSMTP_HOST}, Port => $ENV{AFSMTP_PORT}, Timeout => 5, Hello => `hostname`, Debug => 1) or die "Connect failed";
my %starttls_args;
if ($ENV{AFSMTP_CERT})
{
	$starttls_args{SSL_cert_file} = $ENV{AFSMTP_CERT};
	$starttls_args{SSL_key_file} = $ENV{AFSMTP_KEY};
}
if ($ENV{AFSMTP_CAPATH})
{
	$starttls_args{SSL_ca_path} = $ENV{AFSMTP_CAPATH};
	$starttls_args{SSL_check_crl} = 1;
	$starttls_args{SSL_verify_mode} = 0x01;
}
$smtp->starttls(%starttls_args) or die "STARTTLS failed";
$smtp->hello(`hostname`) or die "HELO/EHLO failed";
$smtp->auth($ENV{AFSMTP_USER}, $ENV{AFSMTP_PASS}) or die "AUTH failed";
$smtp->mail($ENV{AFSMTP_FROM}) or die "MAIL failed";
$smtp->to($ENV{AFSMTP_TO}) or die "RCPT failed";
$smtp->quit or die "QUIT failed";
