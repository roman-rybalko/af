#!/bin/sh -x

. "$TESTCONF"

rm -Rvf .base

del_ldif user.ldif

cnt=50
while [ $cnt -gt 0 ]
do
	kill -0 $pid || break
	cnt=$(($cnt-1))
	usleep 100000
done
kill $pid || true
kill -9 $pid || true
[ $cnt -gt 0 ]
