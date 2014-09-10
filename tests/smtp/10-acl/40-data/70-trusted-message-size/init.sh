#!/bin/sh -ex

. "$TESTCONF"

add_ldif system-tms-init.ldif

start_server mx -e server.env -p 2525 -s 1
rm -f server.env
