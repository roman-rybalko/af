#!/usr/bin/perl

use strict;
use warnings;
use IO::Socket::INET '1.18';
use IO::Socket::SSL;
use Getopt::Std;

my %opts;
getopts('hp:f:s:c:k:', \%opts);

if ($opts{h})
{
	print "USAGE: $0 [options]\n",
		"OPTIONS:\n",
		"\t-h\tThis help screen\n",
		"\t-p port\tListen port, 25 by default\n",
		"\t-f file\tSave messages to file, discard by default\n",
		"\t-s cnt\tAccept cnt sessions then exit, 7777777 by default\n",
		"\t-c cert\tSSL certificate file\n",
		"\t-k key\tSSL key file\n",
		"";
	exit 0;
}
$opts{p} = 25 unless $opts{p};
$opts{c} = 7777777 unless $opts{c};

my @data;

sub session
{
	my $s = shift;
	my $data = 0;
	print $s "220 ESMTP test server\r\n";
	while(<$s>)
	{
		s/\s+$//;

		if ($data)
		{
			if (/^\.$/)
			{
				print $s "250 OK", $opts{f} ? " file=".$opts{f} : "", " linescnt=$#data", "\r\n";
				$data = 0;
			}
			else
			{
				push @data => "$_\n";
			}
			next;
		}

		my ($cmd) = /^(\w+)/;
		$cmd = lc $cmd;
		if ($cmd eq "ehlo")
		{
			print $s "250-OK\r\n","250 STARTTLS\r\n";
		}
		elsif ($cmd eq "starttls")
		{
			print $s "220 OK\r\n";
			my $ss = IO::Socket::SSL->start_SSL($s, SSL_server => 1, SSL_cert_file => $opts{c}, SSL_key_file => $opts{k});
			if ($ss)
			{
				$s = $ss;
			}
			else
			{
				print $s "450 FAIL\r\n";
			}
		}
		elsif ($cmd eq "quit")
		{
			print $s "221 OK\r\n";
			last;
		}
		elsif ($cmd eq "data")
		{
			print $s "354 OK\r\n";
			$data = 1;
		}
		else
		{
			print $s "250 OK\r\n";
		}
	}
}

my $s = IO::Socket::INET->new(Proto => 'tcp', LocalAddr => '0.0.0.0:'.$opts{p}, ReuseAddr => 1);
die "Open tcp socket on port ".$opts{p}." failed" unless $s;
$s->listen;

while($opts{s})
{
	session($s->accept);
	--$opts{s};
}

if ($opts{f})
{
	my $f;
	open $f, ">", $opts{f} or die "Unable to open file ".$opts{f};
	print $f @data;
}
