#!/bin/sh -ex
. ./remote.conf
. ./pkgdep.sh

pkgdep_install submission_exim exim p5-perl-ldap

adduser -f adduser.batch -M 0750 -w no -G "advancedfiltering_ssl advancedfiltering_ldap"

tar -xvf submission.tgz -C /usr/local/

sed "s/template.hosts.advancedfiltering.net/`hostname`/" rc.conf > /etc/rc.conf.d/advancedfiltering_submission_exim

chown -R advancedfiltering_submission:advancedfiltering_submission /usr/local/advancedfiltering/submission
chown root:wheel /usr/local/etc/rc.d/advancedfiltering_submission_exim /etc/rc.conf.d/advancedfiltering_submission_exim
chown root /usr/local/advancedfiltering/submission/exim/configure

crontab -u advancedfiltering_submission cron.batch
./db-mod.sh

service advancedfiltering_submission_exim start
