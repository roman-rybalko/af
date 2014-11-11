#!/bin/sh

# WatchDog Cron wrapper

L=/tmp/mpupdate.lock
if [ -e $L ] && kill -0 `cat $L`; then
	exit 0
fi
echo $$ > $L
`dirname $0`/mpupdate.sh 2>&1 | tail -n 1000
rm -f $L
