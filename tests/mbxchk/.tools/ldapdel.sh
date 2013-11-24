#!/bin/sh -ex
. "$TESTCONF"
cd "$TESTDIR"/.tools
exec ldapdelete -x -D cn=tests,ou=auth -w tests -v -c
