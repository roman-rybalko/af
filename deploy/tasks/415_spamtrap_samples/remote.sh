#!/bin/sh -ex
. ./remote.conf

fetch -o - http://deploy/deploy/samples.tgz | tar -zxvf - -C /usr/local/advancedfiltering/exim/spamtrap/
