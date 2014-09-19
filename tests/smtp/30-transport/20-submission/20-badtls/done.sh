#!/bin/sh -x

. "$TESTCONF"

stop_server submission_notls
rm -f submission_notls.env
stop_server submission
rm -f submission.env
