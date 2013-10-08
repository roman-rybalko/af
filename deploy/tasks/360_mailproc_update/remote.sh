#!/bin/sh -ex
. ./remote.conf

tar -xvf mailproc.tgz -C /usr/local/advancedfiltering/mailproc/
chown -Rv mailproc:mailproc /usr/local/advancedfiltering/mailproc

crontab -u mailproc cron.batch
