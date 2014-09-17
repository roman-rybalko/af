#!/bin/sh -x

. "$TESTCONF"

del_ldif user.ldif

stop_server bounce
rm -f bounce.env
stop_server mx
rm -f mx.env
