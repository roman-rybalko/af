#!/bin/sh -ex

. "$TESTCONF"

start_server submission_notls -s 1 -e submission_notls.env -p 16025
rm -f submission_notls.env
start_server submission -s 1 -e submission.env -p 26025
rm -f submission.env
