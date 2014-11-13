#!/bin/sh -ex
. "$TESTCONF"

export TESTPROC_OK=5 # see logread.conf/MAXPROC
export TESTPROC_FAIL=1 # see logread.conf/MAXPROC
export TESTPROC_LOG=testproc.log

run_target -v 1

! grep FAIL testproc.log
grep Test/ testproc.log
