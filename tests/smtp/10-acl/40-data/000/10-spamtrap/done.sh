#!/bin/sh -x

. "$TESTCONF"

del_ldif system.ldif
add_ldif system-st-off.ldif

stop_server spamtrap
stop_server mx
rm -f server.env
