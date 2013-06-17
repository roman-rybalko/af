#!/bin/sh -ex
. ./remote.conf

pkg_add -r exim

cat configure > /usr/local/etc/exim/configure

adduser -f adduser.batch -M 0700 -w no -G "ssl-key ldap"

grep -v "^exim" /usr/local/advancedfiltering/rc.conf > /usr/local/advancedfiltering/rc.conf.new || true
sed "s/template.hosts.advancedfiltering.net/`hostname`/" rc.conf >> /usr/local/advancedfiltering/rc.conf.new
mv -f /usr/local/advancedfiltering/rc.conf.new /usr/local/advancedfiltering/rc.conf

service exim start
