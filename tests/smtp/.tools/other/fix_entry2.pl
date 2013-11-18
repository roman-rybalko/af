#!/usr/bin/perl

while(<>)
{
	if(/afUServiceRealm=[\w\d]+\+afUServiceName=mdb,ou=user,o=advancedfiltering/i)
	{
		@data = ($_);
		next;
	}
	if (@data)
	{
		if (/^\s*$/)
		{
			print foreach @data;
			@data = ();
		}
		else
		{
			$data[0] =~ s/=mdb/=smtpdb/i if /afUMDBMessageIncoming/i;
			$data[0] =~ s/=mdb/=sdb/i if /afUMDBMessageOutgoing/i;
			s/afUMDB/afUSMTP/ig;
			push @data => $_;
		}
		next;
	}
	print;
}
print foreach @data;
