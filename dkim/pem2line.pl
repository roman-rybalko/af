#!/usr/bin/perl

while(<>)
{
	next if /\-\-\-\-/;
	s/\s+//g;
	print;
}
print "\n";
