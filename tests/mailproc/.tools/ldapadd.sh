#!/bin/sh -ex
. "$TESTCONF"
cd "$TESTDIR"/.tools
exec ldapmodify -a -x -D cn=tests,ou=auth -w tests -v
