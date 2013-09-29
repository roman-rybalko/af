#!/bin/sh -ex

. `dirname $0`/spamtrap.conf

d=`date +%F_%T`
cd $HOME/.spamassassin
rm -Rfv st
mkdir -v st
cp -alv bayes_* st/
tar -zcvf $EXPORT/st_$d.tgz st
ln -sfv st_$d.tgz $EXPORT/st_latest.tgz
rm -Rfv st
