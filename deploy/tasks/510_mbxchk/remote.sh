#!/bin/sh -ex
. ./remote.conf

pkg install -y p5-perl-ldap

adduser -f adduser.batch -M 0700 -w no -G "ldap exim"
echo root > /usr/local/advancedfiltering/mbxchk/.forward
chown mbxchk:mbxchk /usr/local/advancedfiltering/mbxchk/.forward

tar -xvf mbxchk.tgz -C /usr/local/advancedfiltering/mbxchk/
chown -Rv mbxchk:mbxchk /usr/local/advancedfiltering/mbxchk

crontab -u mbxchk cron.batch

./db-mod.sh
