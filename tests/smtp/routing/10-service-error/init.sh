#!/bin/sh -ex

. "$TESTCONF"

start_server error -s 2 -e server.env -r mailproc
start_server mx -p 2525
rm -f server.env
