#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif

start_server mx -s 1 -e mx.env -p 2525
rm -f mx.env
start_server mx2 -p 12525
