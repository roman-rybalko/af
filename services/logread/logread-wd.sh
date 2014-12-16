#!/bin/sh

# WatchDog Cron wrapper

LOCK=/tmp/logread.lock
LOG=/tmp/logread.log
if [ -e $LOCK ] && kill -0 `cat $LOCK`; then
	exit 0
fi
echo $$ > $LOCK
`dirname $0`/logread.sh "$@" >$LOG 2>&1 || tail -n 1000 $LOG
rm -f $LOCK $LOG
