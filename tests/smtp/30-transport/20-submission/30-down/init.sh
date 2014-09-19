#!/bin/sh -ex

. "$TESTCONF"

start_server submission1 -s 1 -e submission1.env -p 16025
rm -f submission1.env
start_server submission2 -s 1 -e submission2.env -p 26025
rm -f submission2.env
