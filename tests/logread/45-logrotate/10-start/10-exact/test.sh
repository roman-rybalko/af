#!/bin/sh -ex
. "$TESTCONF"

export TESTPROC_OK=1
export TESTPROC_LOG=testproc.log

i=1
while [ $i -le 10 ]; do
	echo Test/$i >> logread.log
	i=$(($i+1))
done

run_target

grep Test/10 testproc.log

while [ $i -le 20 ]; do
	echo Test/$i >> logread.log
	i=$(($i+1))
done
mv logread.log logread.log.1
touch logread.log

run_target # finish backup
run_target

grep Test/20 testproc.log

while [ $i -le 30 ]; do
	echo Test/$i >> logread.log
	i=$(($i+1))
done

run_target

grep Test/30 testproc.log
