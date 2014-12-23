#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif
add_ldif user.ldif

start_server ht -e ht.env -m ht.mime -p 10025 -s 1
start_server mx -e mx.env -p 2525 -s 1
rm -f ht.env ht.mime mx.env
