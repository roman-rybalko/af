#!/bin/sh -ex

. "$TESTCONF"

add_ldif system.ldif

start_server mp -e mp.env -m mp.mime -p 11025 -s 1
start_server mx -e mx.env -p 2525 -s 1
rm -f mp.env mp.mime mx.env
