#!/bin/sh -ex
. "$TESTCONF"
cd "$TESTDIR"/.tools
exec ldapsearch -x -D cn=tests,ou=system,o=advancedfiltering -w tests -v -b "$1" -s base '(objectClass=*)'
