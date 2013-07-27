#!/bin/sh -ex
. ./remote.conf

pkg_add -r exim

adduser -f adduser.batch -M 0700 -w no -G "ssl-key ldap"

mv /usr/local/etc/exim/* /usr/local/advancedfiltering/exim/
rm -Rvf /usr/local/etc/exim
ln -s ../advancedfiltering/exim /usr/local/etc/exim

cat configure > /usr/local/etc/exim/configure
mkdir /usr/local/etc/exim/ssl
chown exim /usr/local/etc/exim/ssl

cp dkim-smtp.key /usr/local/etc/exim/
chown exim /usr/local/etc/exim/dkim-smtp.key
chmod og-rwx /usr/local/etc/exim/dkim-smtp.key

grep -v "^exim" /usr/local/advancedfiltering/rc.conf > /usr/local/advancedfiltering/rc.conf.new || true
sed "s/template.hosts.advancedfiltering.net/`hostname`/" rc.conf >> /usr/local/advancedfiltering/rc.conf.new
mv -f /usr/local/advancedfiltering/rc.conf.new /usr/local/advancedfiltering/rc.conf

service exim start
