#!/bin/sh

# WatchDog Cron wrapper

: ${NAME=`basename $0 -wd.sh`}
: ${LOCK:=/tmp/$NAME.lock}
: ${LOG:=/tmp/$NAME.log}
if [ -e $LOCK ] && kill -0 `cat $LOCK`; then
	exit 0
fi
echo $$ > $LOCK
`dirname $0`/$NAME.sh "$@" >$LOG 2>&1 || tail -n 1000 $LOG
rm -f $LOCK $LOG
