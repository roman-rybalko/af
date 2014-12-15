#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif
add_ldif user.ldif

start_server smtp -e smtp.env -p 12525 -s 1
rm -f smtp.env
