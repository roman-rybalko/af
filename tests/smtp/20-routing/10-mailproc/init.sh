#!/bin/sh -ex

. "$TESTCONF"

start_server error -s 1 -e error.env -p 14025
start_server mailproc -s 1 -e mailproc.env -p 11025 -r mailproc
rm -f error.env mailproc.env
