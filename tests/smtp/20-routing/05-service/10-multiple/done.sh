#!/bin/sh -x

. "$TESTCONF"

del_ldif system.ldif
add_ldif system-done.ldif

stop_server mailproc
rm -f mailproc.env
