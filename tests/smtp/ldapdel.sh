#!/bin/sh -ex

. ./test.conf

exec ldapdelete -h $DST_HOST -ZZ -x -D cn=tests,ou=system,o=advancedfiltering -w tests -v
