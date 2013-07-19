#!/bin/sh -ex

. "$TESTCONF"

del_ldif system.ldif
add_ldif system-st-done.ldif

stop_server spamtrap
stop_server mx
rm -f server.env
