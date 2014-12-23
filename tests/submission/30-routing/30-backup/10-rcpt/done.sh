#!/bin/sh -x

. "$TESTCONF"

add_ldif user-done.ldif

stop_server mp
stop_server mx
rm -f mp.env mx.env
