#!/bin/sh -x

. "$TESTCONF"

stop_server submission
rm -f submission.env
