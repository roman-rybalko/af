#!/bin/sh -ex
. ./remote.conf

pkg_add -r p5-Mail-SpamAssassin
mkdir /usr/local/advancedfiltering/ham || true

adduser -f adduser.batch -M 0700 -w no -G "www exim"
echo root > /usr/local/advancedfiltering/spamtrap/.forward
chown spamtrap:spamtrap /usr/local/advancedfiltering/spamtrap/.forward

tar -zxvf spamtrap.tgz -C /usr/local/advancedfiltering/spamtrap/
chown -Rv spamtrap:spamtrap /usr/local/advancedfiltering/spamtrap
mkdir /usr/local/advancedfiltering/https/spamtrap
chown -Rv spamtrap:www /usr/local/advancedfiltering/https/spamtrap
chmod 0750 /usr/local/advancedfiltering/https/spamtrap

su -m spamtrap /usr/local/advancedfiltering/spamtrap/bin/cron.sh

crontab -u spamtrap cron.batch
