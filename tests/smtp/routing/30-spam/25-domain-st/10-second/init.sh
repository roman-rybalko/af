#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif

start_server submission -s 2 -e server.env
rm -f server.env