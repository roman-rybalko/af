#!/bin/sh -x

. "$TESTCONF"

stop_server mx
rm -f mx1.mime
rm -f mx2.mime
