#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif

start_server mx -s 1 -m server.mime -p 2525
rm -f server.mime
