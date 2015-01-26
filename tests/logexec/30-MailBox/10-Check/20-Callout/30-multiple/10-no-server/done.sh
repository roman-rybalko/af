#!/bin/sh -x

. "$TESTCONF"

del_ldif user.ldif

stop_server mx1
stop_server mx2
