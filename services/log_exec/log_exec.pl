#!/usr/bin/perl

use strict;
use warnings;

use FindBin;
use lib ($FindBin::Bin);

sub msg_ok
{
	print "OK\n";
}

sub msg_fail
{
	print "FAIL: @_\n";
}

sub msg_fatal
{
	print "FATAL: @_\n";
}


while (<>)
{
	my ($module) = /(\S+?)</;
	my @args = /<(.*?)>/g;
	if ($module)
	{
		$module =~ s~/~::~g;
		my $result = eval "use $module;${module}::run(" . join(',', map {"\'$_\'"} @args) . ");";
		if ($@)
		{
			$@ =~ s/\n|\r//g;
			msg_fatal($@);
		}
		elsif ($result)
		{
			msg_fail($result);
		}
		else
		{
			msg_ok;
		}
	}
	else
	{
		msg_fatal("parse error");
	}
}
