#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif

start_server mx -s 1 -e mx.env -p 2525
start_server hamtrap -s 1 -e hamtrap.env
rm -f mx.env
rm -f hamtrap.env
