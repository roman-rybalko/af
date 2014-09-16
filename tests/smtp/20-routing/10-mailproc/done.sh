#!/bin/sh -x

. "$TESTCONF"

stop_server error
stop_server mailproc
rm -f error.env mailproc.env
