#!/bin/sh -ex
. "$TESTCONF"

export TESTPROC_FATAL=1

"$TESTDIR"/.target/logread.sh -i logread-test -f local0 &
pid=$!
usleep 500000
kill $pid

./state.pl logread.state
