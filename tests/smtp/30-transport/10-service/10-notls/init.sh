#!/bin/sh -ex

. "$TESTCONF"

start_server mailproc_notls -s 1 -e mailproc_notls.env -p 11025
rm -f mailproc_notls.env
start_server mailproc -s 1 -e mailproc.env -p 21025
rm -f mailproc.env
