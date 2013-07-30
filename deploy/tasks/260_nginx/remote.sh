#!/bin/sh -ex
. ./remote.conf

pkg_add -r nginx

mkdir /usr/local/advancedfiltering/nginx
chown www /usr/local/advancedfiltering/nginx
chmod og-rwx /usr/local/advancedfiltering/nginx
mv /usr/local/etc/nginx/* /usr/local/advancedfiltering/nginx/
rm -Rvf /usr/local/etc/nginx
ln -s ../advancedfiltering/nginx /usr/local/etc/nginx

grep -v "^nginx" /usr/local/advancedfiltering/rc.conf > /usr/local/advancedfiltering/rc.conf.new || true
sed "s/template.hosts.advancedfiltering.net/`hostname`/" rc.conf >> /usr/local/advancedfiltering/rc.conf.new
mv -f /usr/local/advancedfiltering/rc.conf.new /usr/local/advancedfiltering/rc.conf
