#!/bin/sh -ex
. "$TESTCONF"

export TESTPROC_OK=1
export TESTPROC_LOG=testproc.log

start_target
pid=`cat logread.pid`

echo Test/1 >> logread.log
wait_line testproc.log Test/1

[ ! -e logread.state ]
kill -USR1 $pid
wait_file logread.state
rm -f logread.state

# check the target is not terminated
kill -USR2 $pid
echo Test/2 >> logread.log
wait_line testproc.log Test/2

rm -f logread.state
kill $pid
wait_file logread.state
! kill -0 $pid
