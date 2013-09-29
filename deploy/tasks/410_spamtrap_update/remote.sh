#!/bin/sh -ex
. ./remote.conf

tar -zxvf spamtrap.tgz -C /usr/local/advancedfiltering/spamtrap/
chown -Rv spamtrap:spamtrap /usr/local/advancedfiltering/spamtrap

crontab -u spamtrap cron.batch