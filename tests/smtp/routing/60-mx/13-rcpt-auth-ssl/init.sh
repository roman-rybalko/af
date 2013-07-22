#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif

start_server mx -s 1 -e server.env -p 25251
start_server error
rm -f server.env
