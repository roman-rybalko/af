#!/bin/sh -ex
. ./remote.conf

adduser -f adduser.batch -M 0750 -w no -G "advancedfiltering_ssl advancedfiltering_ldap"

tar -xvf smtp.tgz -C /usr/local/

sed "s/template.hosts.advancedfiltering.net/`hostname`/" rc.conf > /etc/rc.conf.d/advancedfiltering_smtp_exim

chown -R advancedfiltering_smtp:advancedfiltering_smtp /usr/local/advancedfiltering/smtp
chown root:wheel /usr/local/etc/rc.d/advancedfiltering_smtp_exim /etc/rc.conf.d/advancedfiltering_smtp_exim
chown root /usr/local/advancedfiltering/smtp/exim/configure

service advancedfiltering_smtp_exim start
