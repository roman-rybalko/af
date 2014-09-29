#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif

start_server spamtrap -e spamtrap.env -p 12025 -s 1
rm -f spamtrap.env
