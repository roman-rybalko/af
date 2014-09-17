#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif

start_server bounce -s 1 -e bounce.env -p 15025
rm -f bounce.env
start_server mx -s 1 -e mx.env -p 2525 -r mbox
rm -f mx.env
