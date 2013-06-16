#!/bin/sh -ex

. $TESTCONF

exec ldapdelete -h $DST_HOST -ZZ -x -D cn=tests,ou=system,o=advancedfiltering -w tests -v
