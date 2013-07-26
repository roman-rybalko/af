#!/bin/sh -x

. "$TESTCONF"

add_ldif system-tms-done.ldif
del_ldif user.ldif

stop_server mx
rm -f server.env
