#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif

start_server mx1 -s 1 -e mx1.env -p 12525
rm -f mx1.env
start_server mx2 -p 22525

./mkca.sh .ssl/testca
