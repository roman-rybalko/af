#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif
add_ldif system-st-on.ldif

start_server spamtrap -p 12025 -s 1 -e server.env
rm -f server.env
