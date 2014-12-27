#!/bin/sh -x

. "$TESTCONF"

stop_server mailproc
rm -f mailproc.mime
