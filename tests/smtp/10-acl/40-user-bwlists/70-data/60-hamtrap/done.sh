#!/bin/sh -x

. "$TESTCONF"

del_ldif user.ldif

stop_server mx
stop_server hamtrap
rm -f mx.env
rm -f hamtrap.env