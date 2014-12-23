#!/bin/sh -x

. "$TESTCONF"

del_ldif user.ldif
del_ldif system.ldif

stop_server mp
stop_server ss
rm -f mp.env ss.env ss.mime
