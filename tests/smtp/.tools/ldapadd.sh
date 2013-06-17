#!/bin/sh -ex
. "$TESTCONF"
cd "$TESTDIR"/.tools
exec ldapmodify -a -h $DST_HOST -ZZ -x -D cn=tests,ou=system,o=advancedfiltering -w tests
