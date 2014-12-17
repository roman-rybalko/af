#!/usr/bin/perl

use strict;
use warnings;
$| = 1;

use FindBin;
use lib ($FindBin::Bin);

sub make_desc
{
	my $desc = "";
	if (@_)
	{
		$desc = ": " . join(" ", @_) if @_;
		$desc =~ s/\s/ /g;
	}
	return $desc;
}

sub msg_ok
{
	my $desc = make_desc(@_);
	print "OK$desc\n";
}

sub msg_fail
{
	my $desc = make_desc(@_);
	print "FAIL$desc\n";
}

sub msg_fatal
{
	my $desc = make_desc(@_);
	print "FATAL$desc\n";
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
				msg_ok("$result, OK");
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
