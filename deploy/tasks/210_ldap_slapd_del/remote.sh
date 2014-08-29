#!/bin/sh -ex
. ./remote.conf

service advancedfiltering_ldap_slapd stop || true
rm -Rvf /usr/local/etc/rc.d/advancedfiltering_ldap_slapd /etc/rc.conf.d/advancedfiltering_ldap_slapd /usr/local/advancedfiltering/ldap
rmuser -yv advancedfiltering_ldap || true
