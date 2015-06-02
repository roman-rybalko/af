#!/bin/sh -x

. "$TESTCONF"

stop_server mx

del_ldif user.ldif
