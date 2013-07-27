#!/bin/sh -ex

. "$TESTCONF"

start_server error -s 2 -e server.env -r mailproc
rm -f server.env
