#!/bin/sh -x

. "$TESTCONF"

stop_server submission1
rm -f submission1.env
stop_server submission2
rm -f submission2.env
