#!/bin/sh -ex
. ./remote.conf

# check group members
[ -z "`pw groupshow advancedfiltering_ldap | awk 'BEGIN{FS=":"}{print $4}'`" ]

service advancedfiltering_ldap_slapd stop || true
rm -Rvf /usr/local/etc/rc.d/advancedfiltering_ldap_slapd /etc/rc.conf.d/advancedfiltering_ldap_slapd /usr/local/advancedfiltering/ldap
rmuser -yv advancedfiltering_ldap || true
