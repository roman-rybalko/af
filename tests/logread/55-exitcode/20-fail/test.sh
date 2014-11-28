#!/bin/sh -ex
. "$TESTCONF"

export TESTPROC_OK=1

"$TESTDIR"/.target/logread.sh -v 2 &
pid=$!
usleep 200000
kill $pid
! wait $pid
