#!/bin/sh -ex

. "$TESTCONF"

add_ldif system-tms-init.ldif

start_server mx -s 1 -e server.env -p 2525
rm -f server.env
