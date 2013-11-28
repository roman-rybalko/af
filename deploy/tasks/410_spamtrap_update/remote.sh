#!/bin/sh -ex
. ./remote.conf

rm -Rvf /usr/local/advancedfiltering/spamtrap/bin
tar -xvf spamtrap.tgz -C /usr/local/advancedfiltering/spamtrap/
chown -Rv spamtrap:spamtrap /usr/local/advancedfiltering/spamtrap

crontab -u spamtrap cron.batch
