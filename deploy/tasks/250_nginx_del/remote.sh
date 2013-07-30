#!/bin/sh -ex
. ./remote.conf

service nginx stop || true

pkg_delete `pkg_info -E 'nginx-*'` || true

grep -v "^nginx" /usr/local/advancedfiltering/rc.conf > /usr/local/advancedfiltering/rc.conf.new || true
mv -f /usr/local/advancedfiltering/rc.conf.new /usr/local/advancedfiltering/rc.conf

rm -Rvf /usr/local/www /usr/local/advancedfiltering/nginx /usr/local/etc/nginx /usr/local/advancedfiltering/http /usr/local/advancedfiltering/https

rmuser -yv www || true
