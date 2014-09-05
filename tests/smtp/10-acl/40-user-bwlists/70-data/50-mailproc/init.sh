#!/bin/sh -ex

. "$TESTCONF"

start_server mailproc -p 11025 -s 1 -e server.env
start_server mx -p 2525
rm -f server.env
