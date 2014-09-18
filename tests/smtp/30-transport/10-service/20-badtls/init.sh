#!/bin/sh -ex

. "$TESTCONF"

start_server mailproc_notls -c test-smtp-black.crt -k test-smtp-black.key -s 3 -p 21025
start_server mailproc -s 3 -e mailproc.env -p 11025
rm -f mailproc.env
