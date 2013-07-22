#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif

start_server mx1 -s 1 -e server1.env -p 25251 -R tests
start_server mx2 -s 1 -e server2.env -p 25252
rm -f server?.env
