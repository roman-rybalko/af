#!/bin/sh -ex

. `dirname $0`/spamtrap.conf

export HOME
rm -fv $HOME/.spamassassin/bayes_*
sa-learn --configpath=$CF --siteconfigpath=$CFSITE --spam $SPAM --progress
sa-learn --configpath=$CF --siteconfigpath=$CFSITE --ham $HAM --progress
