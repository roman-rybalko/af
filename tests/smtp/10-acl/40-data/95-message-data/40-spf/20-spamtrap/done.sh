#!/bin/sh -x

. "$TESTCONF"

add_ldif system-st-off.ldif

stop_server spamtrap
rm -f spamtrap.env
