#!/bin/sh -ex

. "$TESTCONF"

del_ldif system.ldif

stop_server spamtrap
stop_server mx
rm -f server.env
