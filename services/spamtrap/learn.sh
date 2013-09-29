#!/bin/sh -ex

. `dirname $0`/spamtrap.conf

export HOME
sa-learn --configpath=$CF --siteconfigpath=$CFSITE --clear
sa-learn --configpath=$CF --siteconfigpath=$CFSITE --spam $SPAM --progress
sa-learn --configpath=$CF --siteconfigpath=$CFSITE --ham $HAM --progress
