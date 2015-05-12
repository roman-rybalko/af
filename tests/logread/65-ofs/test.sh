#!/bin/sh -ex
. "$TESTCONF"

export TESTPROC_FATAL=1
export TESTPROC_LOG=testproc.log

start_target
pid=`cat logread.pid`
echo Test/1 >> logread.log
wait_line testproc.log Test/1

rm -f logread.state
kill $pid
wait_file logread.state
./state.pl logread.state
