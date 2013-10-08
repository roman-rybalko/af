#!/bin/sh -ex
. ./remote.conf

adduser -f adduser.batch -M 0700 -w no -G "ldap"
echo root > /usr/local/advancedfiltering/ldaprepl/.forward
chown ldaprepl:ldaprepl /usr/local/advancedfiltering/ldaprepl/.forward

tar -zxvf ldaprepl.tgz -C /usr/local/advancedfiltering/ldaprepl/
chown -Rv ldaprepl:ldaprepl /usr/local/advancedfiltering/ldaprepl

crontab -u ldaprepl cron.batch
