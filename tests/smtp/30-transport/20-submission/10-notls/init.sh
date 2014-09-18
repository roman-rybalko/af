#!/bin/sh -ex

. "$TESTCONF"

start_server submission_notls -s 3 -p 16025
start_server submission -s 3 -e submission.env -p 26025
rm -f submission.env
