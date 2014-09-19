#!/bin/sh -x

. "$TESTCONF"

stop_server mailproc1
rm -f mailproc1.env
stop_server mailproc2
rm -f mailproc2.env
