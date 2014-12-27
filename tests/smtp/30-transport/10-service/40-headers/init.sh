#!/bin/sh -ex

. "$TESTCONF"

start_server mailproc -s 1 -m mailproc.mime -p 11025
rm -f mailproc.mime
