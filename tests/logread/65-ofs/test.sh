#!/bin/sh -ex
. "$TESTCONF"

export TESTPROC_FATAL=1

run_target -v 2
run_target -v 2
run_target -v 2

./state.pl logread.state
