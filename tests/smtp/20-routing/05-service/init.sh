#!/bin/sh -ex

. "$TESTCONF"

start_server mailproc -s 1 -e mailproc.env -p 11025
rm -f mailproc.env
