#!/bin/sh -ex

. `dirname $0`/spamtrap.conf

SALSD=`perl -e "use Mail::SpamAssassin; print Mail::SpamAssassin->new->sed_path('__local_state_dir__');"`
export HOME

rm -Rfv $CF.new
mkdir -v $CF.new
sa-update --updatedir $CF.new --gpghomedir $HOME
rm -Rfv $SALSD/compiled
sa-compile --configpath=$CF.new --siteconfigpath=$CFSITE
rm -Rfv $CF $BASE/compiled
mv -v $SALSD/compiled $BASE
mv -v $CF.new $CF
