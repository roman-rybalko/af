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

sub run_expr
{
	my $expr = shift;
	my ($module) = $expr =~ /(.+?)</;
	$module =~ s~/~::~g;
	my @args = $expr =~ /<(.*?)>/g;
	my $result = eval "use $module; ${module}::run(" . join(',', map {"\'$_\'"} @args) . ");";
	die $@ if $@;
	return $result;
}

while (<>)
{
	my $expr_pattern = '(?:\w+/)+\w+(?:<[^>]*>)+';
	if (my ($expr_test, $expr_true, $expr_false) = /^\s*($expr_pattern)\s*\?\s*($expr_pattern)\s*\:\s*($expr_pattern)\s*$/)
	{
		my $result = eval { run_expr($expr_test); };
		if ($@)
		{
			$@ =~ s/\n|\r//g;
			msg_fatal($@);
		}
		elsif ($result)
		{
			my $result2 = eval { run_expr($expr_false); };
			if ($@)
			{
				$@ =~ s/\n|\r//g;
				msg_fatal("$result, $@");
			}
			elsif ($result2)
			{
				msg_fail("$result, $result2");
			}
			else
			{
				msg_ok;
			}
		}
		else
		{
			my $result2 = eval { run_expr($expr_true); };
			if ($@)
			{
				$@ =~ s/\n|\r//g;
				msg_fatal("OK, $@");
			}
			elsif ($result2)
			{
				msg_fail("OK, $result2");
			}
			else
			{
				msg_ok;
			}
		}
	}
	elsif (my ($expr) = /^\s*($expr_pattern)\s*$/)
	{
		my $result = eval { run_expr($expr); };
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
