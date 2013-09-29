#!/bin/sh -ex
. ./remote.conf

pkg_add -r p5-Mail-SpamAssassin
pkg_add -r p5-perl-ldap

adduser -f adduser.batch -M 0700 -w no -G "www ssl-key ldap"
echo root > /usr/local/advancedfiltering/mailproc/.forward
chown mailproc:mailproc /usr/local/advancedfiltering/mailproc/.forward

tar -zxvf mailproc.tgz -C /usr/local/advancedfiltering/mailproc/
chown -Rv mailproc:mailproc /usr/local/advancedfiltering/mailproc
mkdir /usr/local/advancedfiltering/http/mailproc
chown -Rv mailproc:www /usr/local/advancedfiltering/http/mailproc
chmod 0750 /usr/local/advancedfiltering/http/mailproc

crontab -u mailproc cron.batch