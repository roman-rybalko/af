#!/bin/sh -ex

. "$TESTCONF"

start_server submission -s 1 -m submission.mime -p 16025
rm -f submission.mime
