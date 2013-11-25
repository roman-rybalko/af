#!/bin/sh -ex

. "$TESTCONF"

start_server mx -s 1 -e server.env -p 25251 -a
rm -f server.env
