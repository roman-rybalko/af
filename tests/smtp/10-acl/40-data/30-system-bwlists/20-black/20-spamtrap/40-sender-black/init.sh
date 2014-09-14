#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif

start_server spamtrap -e server.env -p 12025 -s 1
rm -f server.env
