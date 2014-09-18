#!/bin/sh -ex

. "$TESTCONF"

start_server submission_notls -c test-smtp-black.crt -k test-smtp-black.key -s 3 -p 26025
start_server submission -s 3 -e submission.env -p 16025
rm -f submission.env
