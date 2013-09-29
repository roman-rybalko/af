#!/bin/sh -ex
. ./remote.conf

fetch -o - http://deploy/deploy/spam-samples.tgz | tar -zxvf - -C /usr/local/advancedfiltering/exim/spamtrap/
for f in /usr/local/advancedfiltering/exim/spamtrap/*; do touch $f; done
fetch -o - http://deploy/deploy/ham-samples.tgz | tar -zxvf - -C /usr/local/advancedfiltering/exim/hamtrap/
for f in /usr/local/advancedfiltering/exim/hamtrap/*; do touch $f; done
