#!/bin/sh -x

. "$TESTCONF"

del_ldif system.ldif

stop_server mx
rm -f mx.mime
