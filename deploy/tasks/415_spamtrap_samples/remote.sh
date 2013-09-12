#!/bin/sh -ex
. ./remote.conf

fetch -o - http://deploy/deploy/samples.tgz | tar -zxvf - -C /usr/local/advancedfiltering/exim/spamtrap/
for f in /usr/local/advancedfiltering/exim/spamtrap/*; do touch $f; done
