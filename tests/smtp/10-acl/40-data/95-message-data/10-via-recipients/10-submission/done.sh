#!/bin/sh -x

. "$TESTCONF"

del_ldif user.ldif

stop_server submission
rm -f submission1.mime
