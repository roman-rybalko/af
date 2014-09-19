#!/bin/sh -x

. "$TESTCONF"

del_ldif user.ldif

stop_server mx
rm -f mx.env
stop_server mx2
rm -f mx2.env
