#!/bin/sh -ex
. "$TESTCONF"
cd "$TESTDIR"/.tools
exec ldapdelete -x -D cn=tests,ou=system,o=advancedfiltering -w tests -v -c
