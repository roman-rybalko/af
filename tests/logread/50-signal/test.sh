#!/bin/sh -ex
. "$TESTCONF"

export TESTPROC_OK=1

"$TESTDIR"/.target/logread.sh -v 2 &
pid=$!
usleep 200000
[ ! -e logread.state ]

kill -USR1 $pid
usleep 200000
kill -0 $pid
[ -e logread.state ]
rm -f logread.state

echo TEST/1 >> logread.log

# check the target is not terminated
kill -USR2 $pid
usleep 200000
kill -0 $pid

kill $pid
usleep 200000
! kill -0 $pid
[ -e logread.state ]
