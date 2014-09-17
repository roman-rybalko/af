#!/bin/sh -ex

. "$TESTCONF"

add_ldif user-init.ldif

start_server mx -s 1 -e mx.env -p 2525
rm -f mx.env
