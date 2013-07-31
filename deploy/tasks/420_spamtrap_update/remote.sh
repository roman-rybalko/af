#!/bin/sh -ex
. ./remote.conf

su -m spamtrap /usr/local/advancedfiltering/spamtrap/bin/cron.sh
