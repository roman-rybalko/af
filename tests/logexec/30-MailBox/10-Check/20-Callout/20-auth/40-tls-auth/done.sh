#!/bin/sh -x

. "$TESTCONF"

del_ldif user.ldif

stop_server mx
rm -f mx.env
