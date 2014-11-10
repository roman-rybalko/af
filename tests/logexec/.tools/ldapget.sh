#!/bin/sh -ex
. "$TESTCONF"
cd "$TESTDIR"/.tools
exec ldapsearch -h $DST_HOST -ZZ -x -D cn=tests,ou=auth -w tests -v -b "$1" -s base '(objectClass=*)'
