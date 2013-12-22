#!/bin/sh -x

. "$TESTCONF"

del_ldif user.ldif

stop_server mx
stop_server mailproc
rm -f mx.env
rm -f mailproc.env
