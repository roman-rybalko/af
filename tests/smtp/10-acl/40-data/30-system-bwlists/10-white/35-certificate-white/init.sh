#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif

start_server mx -e mx.env -p 2525 -s 1
rm -f mx.env
