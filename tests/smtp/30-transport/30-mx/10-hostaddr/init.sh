#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif

start_server mx -s 1 -p 2525
rm -f mx.env
