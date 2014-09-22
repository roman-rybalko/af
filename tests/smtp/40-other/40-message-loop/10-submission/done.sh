#!/bin/sh -x

. "$TESTCONF"

add_ldif system-done.ldif
del_ldif system.ldif
del_ldif user.ldif

stop_server submission
rm -f submission1.mime
