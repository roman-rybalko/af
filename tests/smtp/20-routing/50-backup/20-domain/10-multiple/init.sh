#!/bin/sh -ex

. "$TESTCONF"

add_ldif user-init.ldif

start_server submission -s 1 -e submission.env -p 16025
start_server mx -s 1 -e mx.env -p 2525
rm -f submission.env
rm -f mx.env
