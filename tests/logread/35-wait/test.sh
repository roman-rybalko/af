#!/bin/sh -ex
. "$TESTCONF"

export TESTPROC_OK=1

"$TESTDIR"/.target/logread.sh -i logread-test -f local0 &
pid=$!
usleep 500000

echo TEST/1 >> logread.log
usleep 500000
kill -0 $pid

echo Test/2 >> logread.log
usleep 500000
kill -0 $pid

i=1
while [ $i -lt 10 ]; do
	echo TeSt/$i >> logread.log
	i=$(($i+1))
done
usleep 500000
! kill $pid
