#!/bin/sh -ex
. "$TESTCONF"

export TESTPROC_OK=1
export TESTPROC_LOG=testproc.log

start_target
pid=`cat logread.pid`

wait_line testproc.log Test/1

rm -f logread.state
kill $pid
wait_file logread.state
! wait $pid
