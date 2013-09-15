#!/usr/bin/perl
while(<>)
{
    $flag = 1 if /^SSH:/;
    next unless $flag;
    last if /^\s*$/;
    ($host) = /(\S+)/ if m~/~;
    ($ip) = m~/\s*(\S+)~ if m~/~;
    ($pw) = /(\S+)\s*$/ if /Пароль/i;
}
$host =~ s/.hosts.advancedfiltering.net//;
open $F, ">","$host.pw";
print $F $pw;
close $F;
open $F, ">","$host.ip4";
print $F $ip;
close $F;
