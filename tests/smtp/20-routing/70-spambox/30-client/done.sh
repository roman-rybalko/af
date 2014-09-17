#!/bin/sh -x

. "$TESTCONF"

add_ldif user-done.ldif

stop_server mx
rm -f mx.env
