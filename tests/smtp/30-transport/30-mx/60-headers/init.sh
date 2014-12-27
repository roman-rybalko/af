#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif

start_server mx -s 1 -m mx.mime -p 12525
rm -f mx.mime
