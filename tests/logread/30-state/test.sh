#!/bin/sh -ex
. "$TESTCONF"

export TESTPROC_OK=1
export TESTPROC_LOG=testproc.log

run_target
[ -e logread.state ]
grep Test/5 testproc.log
! grep Test/15 testproc.log

rm -f testproc.log
run_target
[ -e logread.state ]
! grep Test/5 testproc.log
grep Test/15 testproc.log
