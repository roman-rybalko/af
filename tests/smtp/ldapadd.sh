#!/bin/sh -ex

. $TESTCONF

exec ldapmodify -a -h $DST_HOST -ZZ -x -D cn=tests,ou=system,o=advancedfiltering -w tests
