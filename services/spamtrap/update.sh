#!/bin/sh -ex

. `dirname $0`/spamtrap.conf

export HOME
rm -Rfv $CF.new
mkdir -v $CF.new
sa-update --updatedir $CF.new --gpghomedir $HOME
rm -Rfv /var/lib/spamassassin/compiled
sa-compile --configpath=$CF.new --siteconfigpath=$CFSITE
rm -Rfv $CF $BASE/compiled
mv -v /var/lib/spamassassin/compiled $BASE
mv -v $CF.new $CF
