#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif

start_server mx -s 1 -m mx.mime -p 2525
rm -f mx.mime
