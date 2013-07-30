#!/bin/sh -ex

. `dirname $0`/spamtrap.conf

export HOME
sa-learn --configpath=$CF --siteconfigpath=$CFSITE --clear
sa-learn --configpath=$CF --siteconfigpath=$CFSITE --spam $SPAM
sa-learn --configpath=$CF --siteconfigpath=$CFSITE --ham $HAM
