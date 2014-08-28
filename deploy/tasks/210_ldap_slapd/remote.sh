#!/bin/sh -ex
. ./remote.conf

pkg install -y openldap-server

adduser -f adduser.batch -M 0750 -w no -G "advancedfiltering_ssl"

tar -xvf ldap.tgz -C /usr/local/
chown -R advancedfiltering_ldap:advancedfiltering_ldap /usr/local/advancedfiltering/ldap /usr/local/etc/rc.d/advancedfiltering_ldap_slapd

sed -i .orig "s/template.hosts.advancedfiltering.net/`hostname`/" /usr/local/advancedfiltering/ldap/slapd/slapd.d/cn=config.ldif
rm /usr/local/advancedfiltering/ldap/slapd/slapd.d/cn=config.ldif.orig

sed "s/template.hosts.advancedfiltering.net/`hostname`/" advancedfiltering_ldap_slapd > /etc/rc.conf.d/advancedfiltering_ldap_slapd

service advancedfiltering_ldap_slapd start
./db-init.sh
cat olcRootDel.ldif | ldapmodify -x -D cn=admin,ou=auth -w admin
