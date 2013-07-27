#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif
add_ldif system-st-init.ldif

start_server spamtrap -s 1 -e server.env
start_server mx -p 2525
rm -f server.env
