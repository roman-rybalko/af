#!/bin/sh

L=/tmp/mailproc-cron.log
[ ! -e $L ] || exit 1

`dirname $0`/update.sh >$L 2>&1 || cat $L

rm -f $L
