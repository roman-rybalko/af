#!/bin/sh -x

. "$TESTCONF"

del_ldif system.ldif

stop_server spamtrap
stop_server mx
rm -f server.env
