#!/bin/sh -x

. "$TESTCONF"

stop()
{
	pid="$1"
	kill $pid
	cnt=50
	while [ $cnt -gt 0 ]
	do
		kill -0 $pid || break
		cnt=$(($cnt-1))
		usleep 100000
	done
	[ $cnt -gt 0 ] || xargs kill -9 $pid
}

stop `cat mailproc1.pid`
stop `cat mailproc2.pid`

rm -Rvf .base .mime mailproc1.pid mailproc2.pid

del_ldif user-clean.ldif
del_ldif user.ldif
