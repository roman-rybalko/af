#!/bin/sh -ex
. ./remote.conf

su -m spamtrap /usr/local/advancedfiltering/spamtrap/bin/cron.sh
[ -e /usr/local/advancedfiltering/spamtrap/base/cf ]
[ -e /usr/local/advancedfiltering/spamtrap/base/cf-site ]
[ -e /usr/local/advancedfiltering/spamtrap/base/compiled ]
[ -e /usr/local/advancedfiltering/https/spamtrap/cf_latest.tgz ]
