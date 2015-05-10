#!/bin/sh -ex
. "$TESTCONF"

export TESTPROC_OK=1

"$TESTDIR"/.target/logread.sh -i logread-test -f local0 &
pid=$!
usleep 500000
[ ! -e logread.state ]

kill -USR1 $pid
usleep 500000
kill -0 $pid
[ -e logread.state ]
rm -f logread.state

echo TEST/1 >> logread.log

# check the target is not terminated
kill -USR2 $pid
usleep 500000
kill -0 $pid

kill $pid
usleep 500000
! kill -0 $pid
[ -e logread.state ]
