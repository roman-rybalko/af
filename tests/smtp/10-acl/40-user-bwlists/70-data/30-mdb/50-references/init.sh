#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif

start_server mx -s 5 -e mx.env -p 2525
rm -f mx.env
