#!/bin/sh

L=/tmp/spamtrap-work.lock
[ ! -e $L ] || exit 0
touch $L
`dirname $0`/work.sh 2>&1 | tail -n 1000
rm -f $L
