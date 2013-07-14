#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif

start_server mx -s 1 -e server.env -p 2525
start_server error
sleep 1 # wait server to start
rm -f server.env
