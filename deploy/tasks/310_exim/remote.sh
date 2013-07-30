#!/bin/sh -ex
. ./remote.conf

pkg_add -r exim

adduser -f adduser.batch -M 0710 -w no -G "ssl-key ldap"
echo root > /usr/local/advancedfiltering/exim/.forward
chown exim:exim /usr/local/advancedfiltering/exim/.forward

mv /usr/local/etc/exim/* /usr/local/advancedfiltering/exim/
rm -Rvf /usr/local/etc/exim
ln -s ../advancedfiltering/exim /usr/local/etc/exim

grep -v "^exim" /usr/local/advancedfiltering/rc.conf > /usr/local/advancedfiltering/rc.conf.new || true
sed "s/template.hosts.advancedfiltering.net/`hostname`/" rc.conf >> /usr/local/advancedfiltering/rc.conf.new
mv -f /usr/local/advancedfiltering/rc.conf.new /usr/local/advancedfiltering/rc.conf
