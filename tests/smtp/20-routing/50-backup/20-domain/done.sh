#!/bin/sh -x

. "$TESTCONF"

add_ldif user-done.ldif

stop_server submission
stop_server mx
rm -f submission.env mx.env
