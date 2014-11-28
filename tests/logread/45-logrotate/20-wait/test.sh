#!/bin/sh -ex
. "$TESTCONF"

export TESTPROC_OK=1
export TESTPROC_LOG=testproc.log

i=1
while [ $i -le 6 ]; do  # testproc flushes when terminated, see logread.conf/MAXPROC
	echo Test/$i >> logread.log
	i=$(($i+1))
done

"$TESTDIR"/.target/logread.sh -v 2 &
pid=$!

usleep 200000
grep Test/5 testproc.log

mv logread.log logread.log.1
touch logread.log

usleep 200000
! kill $pid
