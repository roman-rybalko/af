#!/bin/sh -ex
while [ -n "$1" ]
do
	#./fix_mid.pl < $1 > $1.new
	#./fix_entry2.pl < $1 > $1.new
	#./fix_entry.pl < $1 > $1.new
	#./fix.pl < $1 > $1.new
	#sed -r 's/afUServiceRealm=(\S+?),afUServiceName=(\S+?),ou=user,o=advancedfiltering/afUServiceRealm=\1+afUServiceName=\2,ou=user,o=advancedfiltering/i' < $1 > $1.new
	#perl -e 'while(<>){if(/^\s*$/){$flag=1;next;}; print "\n" if $flag; $flag=0; print;}' < $1 > $1.new
	#perl -e 'while(<>){$flag=1 if /dn: afUServiceName=\S+?,ou=user,o=advancedfiltering/i; print unless $flag; $flag=0 if /^\s*$/;}' < $1 > $1.new
	#./.tools/ldif_nl.pl < $1 > $1.new
	#diff -u $1 $1.new || true
	#mv -f $1.new $1
	shift
done
