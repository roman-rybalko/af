#!/bin/sh -ex

. "$TESTCONF"

add_ldif system-init.ldif
add_ldif system2.ldif
add_ldif system3.ldif
add_ldif user2.ldif
add_ldif user3.ldif

start_server mx2 -s 5 -e mx2.env -p 22525
rm -f mx2.env
