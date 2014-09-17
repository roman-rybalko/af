#!/bin/sh -ex

. "$TESTCONF"

add_ldif user-init.ldif

start_server submission -s 1 -e submission.env -p 16025
rm -f submission.env
