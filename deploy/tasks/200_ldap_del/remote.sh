#!/bin/sh -ex
. ./remote.conf

service slapd stop || true

pkg delete -y openldap-server || true
pkg autoremove -y

grep -v "^slapd" /usr/local/advancedfiltering/rc.conf > /usr/local/advancedfiltering/rc.conf.new || true
mv -f /usr/local/advancedfiltering/rc.conf.new /usr/local/advancedfiltering/rc.conf

rm -Rvf /usr/local/etc/openldap /usr/local/advancedfiltering/openldap

rmuser -yv ldap || true
