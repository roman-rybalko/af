#!/bin/sh -x

. "$TESTCONF"

del_ldif user.ldif
del_ldif system.ldif

stop_server smtp
rm -f smtp.env
