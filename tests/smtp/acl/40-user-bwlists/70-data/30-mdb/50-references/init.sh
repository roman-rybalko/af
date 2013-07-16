#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif

start_server mx -s 5 -e server.env -p 2525
start_server error
rm -f server.env
