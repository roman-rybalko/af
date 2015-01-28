#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif

start_server smtp -s 2 -e smtp.env -p 2525
rm -f smtp.env
