#!/bin/sh

L=/tmp/ldaprepl-work.lock
if [ -e $L ] && kill -0 `cat $L`; then
	exit 0
fi
echo $$ > $L
`dirname $0`/work.sh 2>&1 | tail -n 1000
rm -f $L
