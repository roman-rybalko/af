#!/bin/sh -x

. "$TESTCONF"

del_ldif system.ldif

stop_server spamtrap
rm -f spamtrap.env
