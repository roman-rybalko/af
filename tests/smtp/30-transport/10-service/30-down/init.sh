#!/bin/sh -ex

. "$TESTCONF"

start_server mailproc1 -s 1 -e mailproc1.env -p 11025
rm -f mailproc1.env
start_server mailproc2 -s 1 -e mailproc2.env -p 21025
rm -f mailproc2.env
