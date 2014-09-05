#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif
add_ldif system-ht-on.ldif

start_server mx -s 1 -e mx.env -p 2525
start_server hamtrap -s 1 -e hamtrap.env -p 13025
rm -f mx.env
rm -f hamtrap.env
