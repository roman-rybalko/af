#!/bin/sh -ex
. "$TESTCONF"

export TESTPROC_OK=1

echo Test/1 > logread.log
echo test2 >> logread.log
echo test3 >> logread.log

"$TESTDIR"/.target/logread.sh -i logread-test -f local0 &
pid=$!
usleep 200000

echo Test/4 >> logread.log
echo test5 >> logread.log
usleep 200000

kill $pid
wait $pid || true
./state.pl logread.state
