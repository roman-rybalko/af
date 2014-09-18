#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif
add_ldif system-init.ldif

start_server mailproc -s 1 -e mailproc.env -p 21025
rm -f mailproc.env
