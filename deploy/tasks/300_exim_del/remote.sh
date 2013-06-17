#!/bin/sh -ex
. ./remote.conf

service exim stop

pkg_delete `pkg_info -E 'exim-*'`

grep -v "^exim" /usr/local/advancedfiltering/rc.conf > /usr/local/advancedfiltering/rc.conf.new || true
mv -f /usr/local/advancedfiltering/rc.conf.new /usr/local/advancedfiltering/rc.conf

rm -Rvf /usr/local/etc/exim /usr/local/advancedfiltering/exim

pw userdel exim || true
