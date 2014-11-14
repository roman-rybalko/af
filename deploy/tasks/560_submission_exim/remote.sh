#!/bin/sh -ex
. ./remote.conf
. ./pkgdep.sh

pkgdep_install submission_exim exim p5-perl-ldap

adduser -f adduser.batch -M 0750 -w no -G "af_ssl af_ldap"

tar -xvf submission.tgz -C /usr/local/

sed "s/template.hosts.advancedfiltering.net/`hostname`/" rc.conf > /etc/rc.conf.d/advancedfiltering_submission_exim

chown -R af_submission:af_submission /usr/local/advancedfiltering/submission
chown root:wheel /usr/local/etc/rc.d/advancedfiltering_submission_exim /etc/rc.conf.d/advancedfiltering_submission_exim
for f in /usr/local/advancedfiltering/submission/exim/*; do
	[ ! -f $f ] || chown root $f
done
chown root /usr/local/advancedfiltering/submission/exim
chown -Rv root /usr/local/advancedfiltering/submission/mbxchk/*

crontab -u af_submission cron.batch
./db-mod.sh

service advancedfiltering_submission_exim start
