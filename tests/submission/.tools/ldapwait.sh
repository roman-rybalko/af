#!/bin/sh -ex
. "$TESTCONF"
cd "$TESTDIR"/.tools
[ "$1" = add ] && inv=1 || inv=
shift
cnt=50
search()
{
	if [ -n "$inv" ]; then
		! ldapsearch -h $DST_HOST -ZZ -x -D cn=tests,ou=auth -w tests -b "$*" -s base '(objectClass=*)'
	else
		ldapsearch -h $DST_HOST -ZZ -x -D cn=tests,ou=auth -w tests -b "$*" -s base '(objectClass=*)'
	fi
}
while search "$*"; do
	cnt=$(($cnt-1))
	[ $cnt -gt 0 ] || break
	usleep 100000
done
[ $cnt -gt 0 ]
