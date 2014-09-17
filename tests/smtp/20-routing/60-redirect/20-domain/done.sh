#!/bin/sh -x

. "$TESTCONF"

add_ldif user-done.ldif

stop_server submission
rm -f submission.env
