#!/bin/sh -x

. "$TESTCONF"

del_ldif user-clean.ldif
del_ldif user.ldif
rm -vf .tasks/r1-cli1-test.com-absent

stop_server mx
#rm -f server.env
