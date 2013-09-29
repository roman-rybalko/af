#!/bin/sh -ex
. ./remote.conf

pkg_add -r p5-Mail-SpamAssassin

adduser -f adduser.batch -M 0700 -w no -G "www exim spamd"
echo root > /usr/local/advancedfiltering/spamtrap/.forward
chown spamtrap:spamtrap /usr/local/advancedfiltering/spamtrap/.forward

tar -zxvf spamtrap.tgz -C /usr/local/advancedfiltering/spamtrap/

SALSD=`perl -e "use Mail::SpamAssassin; print Mail::SpamAssassin->new->sed_path('__local_state_dir__');"`
mkdir $SALSD || true
chown spamd:spamd $SALSD
chmod 0770 $SALSD

chown -Rv spamtrap:spamtrap /usr/local/advancedfiltering/spamtrap
mkdir /usr/local/advancedfiltering/https/spamtrap
chown -Rv spamtrap:www /usr/local/advancedfiltering/https/spamtrap
chmod 0750 /usr/local/advancedfiltering/https/spamtrap
chown -Rv spamtrap:exim /usr/local/advancedfiltering/exim/spamtrap
chmod 0770 /usr/local/advancedfiltering/exim/spamtrap
chown -Rv spamtrap:exim /usr/local/advancedfiltering/exim/hamtrap
chmod 0770 /usr/local/advancedfiltering/exim/hamtrap

crontab -u spamtrap cron.batch
