#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif

start_server mx -s 1 -e server.env -p 2525
start_server error
rm -f server.env
