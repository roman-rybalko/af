#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif

start_server smtp -s 3 -e smtp.env -p 2525
rm -f smtp.env
