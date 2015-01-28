#!/bin/sh -ex
. "$TESTCONF"

export TESTPROC_OK=1
export TESTPROC_LOG=testproc.log
export FILTER="(TE(?:S|Z)T/.+)"

run_target

grep TEST/1 testproc.log
grep TEZT/3 testproc.log
