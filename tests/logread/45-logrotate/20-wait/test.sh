#!/bin/sh -ex
. "$TESTCONF"

export TESTPROC_OK=1
export TESTPROC_LOG=testproc.log

i=1
while [ $i -le 6 ]; do
	echo Test/$i >> logread.log
	i=$(($i+1))
done

start_target
pid=`cat logread.pid`
wait_line testproc.log Test/5

rm -f logread.state
mv logread.log logread.log.1
touch logread.log
wait_file logread.state
! kill $pid
