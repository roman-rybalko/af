#!/bin/sh -ex
. "$TESTCONF"

export TESTPROC_OK=1
export TESTPROC_LOG=testproc.log

i=1
while [ $i -le 15 ]; do
	echo Test/$i >> logread.log
	i=$(($i+1))
done

run_target -v 2

grep Test/10 testproc.log

mv logread.log logread.log.1
while [ $i -le 25 ]; do
	echo Test/$i >> logread.log
	i=$(($i+1))
done

run_target -v 2

grep Test/15 testproc.log
! grep Test/16 testproc.log

run_target -v 2

grep Test/25 testproc.log
! grep Test/26 testproc.log
