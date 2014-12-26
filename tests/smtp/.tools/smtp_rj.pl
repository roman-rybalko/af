#!/usr/bin/perl

# SMTP Reply Join

while(<>)
{
	if (/((?:^|.*\s)\d\d\d)([ -])(.*)/)
	{
		$prefix = $1;
		$flag = $2;
		$msg = $3;
		chomp $msg;
		if ($flag eq " ")
		{
			if (@msg)
			{
				print $prefix, " ", join(" ", @msg), " ", $msg, "\n";
				undef @msg;
				next;
			}
			else
			{
				print;
				next;
			}
		}
		else
		{
			push @msg => $msg;
			next;
		}
	}
	else
	{
		print;
		next;
	}
}
