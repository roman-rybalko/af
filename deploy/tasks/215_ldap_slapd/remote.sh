#!/bin/sh -ex
. ./remote.conf

adduser -f adduser.batch -M 0750 -w no -G "advancedfiltering_ssl"

tar -xvf ldap.tgz -C /usr/local/

sed -i .orig "s/template.hosts.advancedfiltering.net/`hostname`/" /usr/local/advancedfiltering/ldap/slapd/slapd.d/cn=config.ldif
rm /usr/local/advancedfiltering/ldap/slapd/slapd.d/cn=config.ldif.orig

sed "s/template.hosts.advancedfiltering.net/`hostname`/" rc.conf > /etc/rc.conf.d/advancedfiltering_ldap_slapd

chown -R advancedfiltering_ldap:advancedfiltering_ldap /usr/local/advancedfiltering/ldap
chown root:wheel /usr/local/etc/rc.d/advancedfiltering_ldap_slapd /etc/rc.conf.d/advancedfiltering_ldap_slapd

service advancedfiltering_ldap_slapd start

./db-init.sh
