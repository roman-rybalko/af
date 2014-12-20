#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif
add_ldif user.ldif

start_server ht -e ht.env -p 10025 -s 1
rm -f ht.env
