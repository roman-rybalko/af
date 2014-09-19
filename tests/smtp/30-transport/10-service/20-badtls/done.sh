#!/bin/sh -x

. "$TESTCONF"

stop_server mailproc_notls
rm -f mailproc_notls.env
stop_server mailproc
rm -f mailproc.env
