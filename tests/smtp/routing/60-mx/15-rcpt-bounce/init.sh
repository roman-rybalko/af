#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif

start_server mx -s 1 -p 25251 -r mbox@test.com
start_server bounce -s 1 -e server.env
rm -f server.env
