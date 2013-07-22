#!/bin/sh -ex
. ./remote.conf

pkg_add -r openldap-server

pw user mod ldap -G ssl-key

tar -zxvf openldap.tgz -C /usr/local/

sed -i .orig "s/template.hosts.advancedfiltering.net/`hostname`/" "/usr/local/etc/openldap/slapd.d/cn=config.ldif"
rm "/usr/local/etc/openldap/slapd.d/cn=config.ldif.orig"

grep -v "^slapd" /usr/local/advancedfiltering/rc.conf > /usr/local/advancedfiltering/rc.conf.new || true
sed "s/template.hosts.advancedfiltering.net/`hostname`/" rc.conf >> /usr/local/advancedfiltering/rc.conf.new
mv -f /usr/local/advancedfiltering/rc.conf.new /usr/local/advancedfiltering/rc.conf

service slapd start
cat crcfix.ldif schema-advancedfiltering.ldif db-init.ldif db-init2.ldif olcAccess.ldif olcLimits.ldif | ldapmodify -a -x -D cn=deploy,cn=config -w deploy
cat olcRootDel.ldif | ldapmodify -x -D cn=admin,ou=system,o=advancedfiltering -w admin
