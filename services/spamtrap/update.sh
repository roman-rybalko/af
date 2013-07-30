#!/bin/sh -ex

. `dirname $0`/spamtrap.conf

export HOME
rm -Rf $UPDATE
mkdir $UPDATE
sa-update --updatedir $UPDATE --gpghomedir $HOME
sa-compile --configpath=$CF --siteconfigpath=$CFSITE --updatedir=$UPDATE
