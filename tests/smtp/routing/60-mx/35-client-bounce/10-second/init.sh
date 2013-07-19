#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif

start_server mx -p 25252 -r mbox@test.com
start_server bounce -s 1 -e server.env
rm -f server.env
