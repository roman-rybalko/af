#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif

start_server mx_notls -c test-smtp-black.crt -k test-smtp-black.key -s 1 -e mx.env -p 12525
rm -f mx.env
start_server mx2 -s 1 -e mx2.env -p 22525
rm -f mx2.env
