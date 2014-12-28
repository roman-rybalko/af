#!/bin/sh -ex

. "$TESTCONF"

add_ldif user-init.ldif

start_server mp -e mp.env -p 11025 -s 1
start_server mx -e mx.env -p 2525 -s 3
rm -f mp.env mx.env
