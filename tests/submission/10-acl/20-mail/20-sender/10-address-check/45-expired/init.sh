#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif
add_ldif user.ldif

start_server smtp -e smtp.env -p 12525 -s 1 -r mbox2@test.advancedfiltering.net
rm -f smtp.env
