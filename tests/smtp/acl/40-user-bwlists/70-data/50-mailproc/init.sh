#!/bin/sh -ex

. "$TESTCONF"

start_server mailproc -s 1 -e server.env
start_server mx -p 2525
rm -f server.env
