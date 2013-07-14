#!/bin/sh -ex

. "$TESTCONF"

del_ldif user.ldif

stop_server mx
stop_server error
rm -f server.env
