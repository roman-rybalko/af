#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif

start_server mx -s 2 -e mx.env -p 2525
rm -f mx.env
