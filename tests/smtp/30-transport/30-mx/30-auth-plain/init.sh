#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif

start_server mx -s 1 -e mx.env -p 12525
rm -f mx.env
start_server mx2 -s 1 -e mx2.env -p 22525 -a
rm -f mx2.env
