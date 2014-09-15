#!/bin/sh -ex

. "$TESTCONF"

start_server mailproc -e server.env -p 11025 -s 1
rm -f server.env
