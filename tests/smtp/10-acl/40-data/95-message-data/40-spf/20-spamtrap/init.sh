#!/bin/sh -ex

. "$TESTCONF"

add_ldif system-st-on.ldif

start_server spamtrap -s 2 -e spamtrap.env -p 12025
rm -f spamtrap.env
