#!/bin/sh -ex
. ./remote.conf

service advancedfiltering_smtp_exim stop || true
rm -Rvf /usr/local/etc/rc.d/advancedfiltering_smtp_exim /etc/rc.conf.d/advancedfiltering_smtp_exim /usr/local/advancedfiltering/smtp
rmuser -yv advancedfiltering_smtp || true
