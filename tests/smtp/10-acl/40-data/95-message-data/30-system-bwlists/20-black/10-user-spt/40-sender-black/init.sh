#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif

start_server mx -s 4 -e mx.env -p 2525
rm -f mx.env