#!/bin/sh -ex

. "$TESTCONF"

add_ldif user.ldif

start_server mx1_notls -s 1 -e mx1.env -p 12525
rm -f mx1.env
start_server mx2_notls -p 22525
