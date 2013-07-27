#!/bin/sh -x

. "$TESTCONF"

del_ldif user.ldif

stop_server spamtrap
rm -f server.env
