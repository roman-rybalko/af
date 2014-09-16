#!/bin/sh -x

. "$TESTCONF"

del_ldif system.ldif
del_ldif user.ldif

stop_server service
rm -f service.env
