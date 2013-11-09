#!/bin/sh -ex
. ./remote.conf

pkg_add -r p5-perl-ldap

adduser -f adduser.batch -M 0700 -w no -G "ldap"
echo root > /usr/local/advancedfiltering/ldaprepl/.forward
chown ldaprepl:ldaprepl /usr/local/advancedfiltering/ldaprepl/.forward

tar -xvf ldaprepl.tgz -C /usr/local/advancedfiltering/ldaprepl/
chown -Rv ldaprepl:ldaprepl /usr/local/advancedfiltering/ldaprepl

crontab -u ldaprepl cron.batch

./db-mod.sh
