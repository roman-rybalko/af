#!/usr/bin/perl

while(<>)
{
	if(/dn: afUServiceRealm=[\w\d]+\+afUServiceName=mdb,ou=user,o=advancedfiltering/i)
	{
		@data = ($_);
		next;
	}
	if (@data)
	{
		if (/^\s*$/)
		{
			foreach (@data)
			{
				$line = $_;
				$line =~ s/=mdb/=smtpdb/g;
				print $line;
			}
			print "\n";
			foreach (@data)
			{
				$line = $_;
				$line =~ s/=mdb/=sdb/g;
				print $line;
			}
			print "\n";
			@data = ();
			next;
		}
		else
		{
			push @data => $_;
		}
		next;
	}
	print;
}
