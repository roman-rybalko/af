#!/bin/sh -x

. "$TESTCONF"

stop_server mailproc
stop_server mx
rm -f server.env
