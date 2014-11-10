#!/bin/sh -ex
. "$TESTCONF"
cd "$TESTDIR"/.tools
exec ldapdelete -h $DST_HOST -ZZ -x -D cn=tests,ou=auth -w tests -v -c
