#!/bin/sh -ex

. "$TESTCONF"

add_ldif system-st-on.ldif

start_server spamtrap -e server.env -p 12025 -s 1
rm -f server.env
