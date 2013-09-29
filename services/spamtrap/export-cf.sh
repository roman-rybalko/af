#!/bin/sh -ex

. `dirname $0`/spamtrap.conf

d=`date +%F_%T`
cd $BASE
tar -zcvf $EXPORT/cf_$d.tgz *
ln -sfv cf_$d.tgz $EXPORT/cf_latest.tgz
