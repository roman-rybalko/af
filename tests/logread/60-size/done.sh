#!/bin/sh -x
. "$TESTCONF"

stop_target
rm -f logread.state logread.log testproc.log
