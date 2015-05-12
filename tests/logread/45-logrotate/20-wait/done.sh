#!/bin/sh -x
. "$TESTCONF"

stop_target
rm -f logread.state testproc.log logread.log logread.log.1
