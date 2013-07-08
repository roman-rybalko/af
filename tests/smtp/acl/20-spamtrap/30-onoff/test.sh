#!/bin/sh -ex

. "$TESTCONF"

doit()
{
	opt=$1
	pass=
	cnt=10
	while [ $cnt -gt 0 ]
	do
		if swaks -f test@advancedfiltering.net -t mail@test.com -s $DST_HOST -q helo | grep ESMTP | grep $opt spamtrap
		then
			pass=1
			break
		fi
		cnt=$(($cnt-1))
	done
	[ -n "$pass" ]
}

doit
doit -v