#!/bin/sh -ex
. ./remote.conf

sed "s/template.hosts.advancedfiltering.net/`hostname`/" nginx.conf > /usr/local/etc/nginx/nginx.conf

mkdir /usr/local/advancedfiltering/http /usr/local/advancedfiltering/https
chown www:www /usr/local/advancedfiltering/http /usr/local/advancedfiltering/https
chmod u=rwx,g=rx,o-rwx /usr/local/advancedfiltering/http /usr/local/advancedfiltering/https

service nginx start
