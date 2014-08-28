#!/bin/sh -ex
. ./remote.conf

service slapd stop || true
service advancedfiltering_ldap_slapd stop || true

pkg delete -y openldap-server || true
pkg autoremove -y

rm -Rvf /usr/local/etc/rc.d/advancedfiltering_ldap_slapd /etc/rc.conf.d/advancedfiltering_ldap_slapd /usr/local/advancedfiltering/ldap

rmuser -yv ldap || true
rmuser -yv advancedfiltering_ldap || true
