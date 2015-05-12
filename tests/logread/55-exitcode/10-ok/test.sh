#!/bin/sh -ex
. "$TESTCONF"

export TESTPROC_OK=1

start_target
pid=`cat logread.pid`
wait_file logread.state
wait $pid
