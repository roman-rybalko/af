#!/bin/sh -ex
. "$TESTCONF"

export TESTPROC_OK=1
export TESTPROC_LOG=testproc.log

run_target -v 2

! grep TEST/1 testproc.log
grep Test/2 testproc.log
! grep TEST/3 testproc.log
! grep test/4 testproc.log
grep Test/5 testproc.log
