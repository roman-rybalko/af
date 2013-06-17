#!/usr/bin/perl

while(<>)
{
	chomp;
	print "\n" if /^\S/;
	print "\n" if /^\s*$/;
	s/^ //;
	print;
}
print "\n";
