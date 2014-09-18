#!/bin/sh -ex

. "$TESTCONF"

start_server mailproc_notls -s 3 -p 11025
start_server mailproc -s 3 -e mailproc.env -p 21025
rm -f mailproc.env
