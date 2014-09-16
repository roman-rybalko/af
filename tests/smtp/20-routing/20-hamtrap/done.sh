#!/bin/sh -x

. "$TESTCONF"

del_ldif user.ldif
add_ldif system-ht-off.ldif

stop_server mx
stop_server hamtrap
rm -f mx.env hamtrap.env
