#!/bin/sh -ex

. "$TESTCONF"

start_server submission -s 3 -e submission.env -p 26025
rm -f submission.env
