#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif
add_ldif system-st-init.ldif
add_ldif user.ldif

start_server submission -s 2 -e server.env
start_server mx -p 2525
rm -f server.env
