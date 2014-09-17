#!/bin/sh -x

. "$TESTCONF"

add_ldif user-done.ldif
del_ldif user.ldif

stop_server mx
rm -f mx.env
