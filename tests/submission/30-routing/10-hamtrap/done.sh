#!/bin/sh -x

. "$TESTCONF"

del_ldif user2.ldif
del_ldif user.ldif
del_ldif system.ldif

stop_server ht
stop_server mx
rm -f ht.env ht.mime mx.env
