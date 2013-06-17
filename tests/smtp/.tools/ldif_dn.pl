#!/usr/bin/perl

while(<>)
{
	next unless /^dn:/;
	s/^dn:\s*//;
	push @dn => $_;
}
print sort { length($b) <=> length($a) } @dn;
