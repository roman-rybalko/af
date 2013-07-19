#!/bin/sh -x

. "$TESTCONF"

del_ldif user.ldif

stop_server mx
stop_server bounce
rm -f server.env
