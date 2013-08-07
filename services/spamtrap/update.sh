#!/bin/sh -ex

. `dirname $0`/spamtrap.conf

export HOME
rm -Rf $UPDATE.new
mkdir $UPDATE.new
sa-update --updatedir $UPDATE.new --gpghomedir $HOME
sa-compile --configpath=$CF --siteconfigpath=$CFSITE --updatedir=$UPDATE.new
rm -Rf $UPDATE
mv $UPDATE.new $UPDATE
