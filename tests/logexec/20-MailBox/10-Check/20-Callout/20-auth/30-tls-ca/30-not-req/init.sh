#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif

start_server mx -s 2 -e mx.env -p 12525
rm -f mx.env

./mkca.sh .ssl/testca
