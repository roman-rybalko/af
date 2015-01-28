#!/bin/sh -ex

. "$TESTCONF"

add_ldif user-init.ldif
add_ldif user.ldif

start_server mx -s 1 -e mx.env -p 32525
rm -f mx.env
