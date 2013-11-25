#!/bin/sh -x

. "$TESTCONF"

del_ldif user.ldif
rm -vf .tasks/r1-cli1-test.com-absent

stop_server mx_notls
rm -f server.env
