#!/bin/sh -x

. "$TESTCONF"

stop_server error
rm -f server.env
