#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif

start_server mx -s 1 -e mx.env -p 2525
start_server mailproc -s 1 -e mailproc.env
rm -f mx.env
rm -f mailproc.env
