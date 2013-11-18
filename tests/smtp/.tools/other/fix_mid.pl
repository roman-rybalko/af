#!/usr/bin/perl

while(<>)
{
	if(/afUSMTPMessageId=(\S+?),/i)
	{
		$n=`./decode_mid.pl '$1'`;
		chomp $n;
		$n =~ s/^.*?<//g;
		$n =~ s/>.*?$//g;
		$e=`./encode_mid.pl '$n'`;
		chomp $e;
		s/afUSMTPMessageId=\S+?,/afUSMTPMessageId=$e,/i;
	}
	if(/afUSMTPMessageId:\s*(\S+)/i)
	{
		$n=`./decode_mid.pl '$1'`;
		chomp $n;
		$n =~ s/^.*?<//g;
		$n =~ s/>.*?$//g;
		$e=`./encode_mid.pl '$n'`;
		chomp $e;
		s/afUSMTPMessageId:\s*\S+/afUSMTPMessageId: $e/i;
	}
	print;
}