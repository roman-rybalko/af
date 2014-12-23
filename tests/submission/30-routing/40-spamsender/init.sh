#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif
add_ldif user.ldif

start_server mp -e mp.env -p 11025 -s 1
start_server ss -e ss.env -m ss.mime -p 12025 -s 1
rm -f mp.env ss.env ss.mime
