#!/bin/sh -x

. "$TESTCONF"

stop_server mailproc_notls
stop_server mailproc
rm -f mailproc.env
