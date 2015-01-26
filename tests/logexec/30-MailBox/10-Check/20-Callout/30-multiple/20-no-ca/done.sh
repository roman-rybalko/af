#!/bin/sh -x

. "$TESTCONF"

del_ldif user.ldif

stop_server mx1
rm -f mx1.env
stop_server mx2

rm -Rvf .ssl/testca
