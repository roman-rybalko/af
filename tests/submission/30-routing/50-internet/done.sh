#!/bin/sh -x

. "$TESTCONF"

del_ldif system.ldif

stop_server mp
stop_server mx
rm -f mp.env mx.env mx.mime
