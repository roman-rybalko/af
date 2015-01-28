#!/bin/sh -ex
. ./remote.conf
. ./pkgdep.sh

pkgdep_install smtp_exim exim p5-perl-ldap p5-Net-DNS

adduser -f adduser.batch -M 0750 -w no -G "af_ssl af_ldap"

tar -xvf smtp.tgz -C /usr/local/

sed "s/template.hosts.advancedfiltering.net/`hostname`/" rc.conf > /etc/rc.conf.d/advancedfiltering_smtp_exim

chown -R af_smtp:af_smtp /usr/local/advancedfiltering/smtp
chown root:wheel /usr/local/etc/rc.d/advancedfiltering_smtp_exim /etc/rc.conf.d/advancedfiltering_smtp_exim
for f in /usr/local/advancedfiltering/smtp/exim/*; do
	[ ! -f $f ] || chown root $f
done
chown root /usr/local/advancedfiltering/smtp/exim
chown -Rv root /usr/local/advancedfiltering/smtp/mbxchk/*

crontab -u af_smtp cron.batch
./db-mod.sh

service advancedfiltering_smtp_exim start
