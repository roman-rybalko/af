#!/bin/sh -x

. "$TESTCONF"

del_ldif user.ldif

stop_server mx1_notls
rm -f mx1.env
stop_server mx2_notls
