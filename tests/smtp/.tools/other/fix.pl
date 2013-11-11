#!/usr/bin/perl

while(<>)
{
	if(/afUMDBMessageId=(\S+?),/i)
	{
		$n = '<' . $1 . '>';
		$e=`./encode_mid.pl '$n'`;
		chomp $e;
		s/afUMDBMessageId=\S+?,/afUMDBMessageId=$e,/i;
	}
	if(/afUMDBMessageId:\s*(\S+)/i)
	{
		$n = '<' . $1 . '>';
		$e=`./encode_mid.pl '$n'`;
		chomp $e;
		s/afUMDBMessageId:\s*\S+/afUMDBMessageId: $e/i;
	}
	print;
}