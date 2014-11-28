#!/bin/sh -ex
. "$TESTCONF"

export TESTPROC_OK=3 # see logread.conf/MAXPROC
export TESTPROC_FATAL=1 # see logread.conf/MAXPROC
export TESTPROC_LOG=testproc.log

run_target

grep FATAL testproc.log
