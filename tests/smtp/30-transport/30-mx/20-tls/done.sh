#!/bin/sh -x

. "$TESTCONF"

del_ldif user.ldif

stop_server mx_notls
rm -f mx.env
stop_server mx2_notls
rm -f mx2.env
