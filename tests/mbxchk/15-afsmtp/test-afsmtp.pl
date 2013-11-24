#!/usr/bin/perl

use strict;
use warnings;
use AdvancedFiltering::SMTP;

my $smtp = AdvancedFiltering::SMTP->new('smtp.gmail.com', Port => 587, Timeout => 5, Hello => `hostname`, Debug => 1) or die "Connect failed";
$smtp->starttls(SSL_cert_file => 'tests.crt', SSL_key_file => 'tests.key') or die "STARTTLS failed";
warn "ISA=@AdvancedFiltering::SMTP::ISA";
warn "ref=", ref $smtp;
$smtp->hello(`hostname`) or die "HELO/EHLO failed";
$smtp->auth('advancedfilteringtest@gmail.com', 'advancedfilteringtest1') or die "AUTH failed";
$smtp->mail('test@test.com') or die "MAIL failed";
$smtp->to('advancedfilteringtest@gmail.com') or die "RCPT failed";
$smtp->quit or die "QUIT failed";
