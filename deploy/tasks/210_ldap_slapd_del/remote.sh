#!/bin/sh -ex
. ./remote.conf
. ./pkgdep.sh

# check group members
[ -z "`pw groupshow af_ldap | awk 'BEGIN{FS=":"}{print $4}'`" ]

service advancedfiltering_ldap_slapd stop || true
rm -Rvf /usr/local/etc/rc.d/advancedfiltering_ldap_slapd /etc/rc.conf.d/advancedfiltering_ldap_slapd /usr/local/advancedfiltering/ldap
rmuser -yv af_ldap || true

pkgdep_uninstall ldap_slapd openldap-server
pkgdep_cleanup openldap-server 'rmuser -yv ldap || true'
