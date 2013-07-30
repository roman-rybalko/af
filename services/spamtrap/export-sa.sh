#!/bin/sh -ex

. `dirname $0`/spamtrap.conf

d=`date +%F_%T`
cd $HOME
tar -zcvf $EXPORT/sa_$d.tgz .spamassassin
ln -sf sa_$d.tgz $EXPORT/sa_latest.tgz
