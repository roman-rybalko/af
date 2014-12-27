#!/bin/sh -x

. "$TESTCONF"

sleep 5
stop_server mx1

del_ldif user.ldif
