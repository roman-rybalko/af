#!/bin/sh -x

. "$TESTCONF"

del_ldif user.ldif
rm -vf .tasks/r1-cli1-test.com-absent
