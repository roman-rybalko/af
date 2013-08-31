#!/bin/sh

L=/tmp/mailproc-cron.log
[ ! -e $L ] || exit 1

`dirname $0`/update.sh 2>&1 >$L || cat $L

rm -f $L
