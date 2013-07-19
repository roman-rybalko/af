#!/bin/sh -x

. "$TESTCONF"

del_ldif system.ldif

stop_server mx
stop_server error
rm -f server.env
