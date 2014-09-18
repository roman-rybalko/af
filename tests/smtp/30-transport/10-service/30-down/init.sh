#!/bin/sh -ex

. "$TESTCONF"

start_server mailproc -s 3 -e mailproc.env -p 21025
rm -f mailproc.env
