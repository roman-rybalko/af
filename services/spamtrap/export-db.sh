#!/bin/sh -ex

. `dirname $0`/spamtrap.conf

d=`date +%F_%T`
cd $HOME
tar -zcvf $EXPORT/db_$d.tgz *
ln -sf db_$d.tgz $EXPORT/db_latest.tgz
