#!/bin/sh -ex
. ./remote.conf

# check group members
[ -z "`pw groupshow advancedfiltering_smtp | awk 'BEGIN{FS=":"}{print $4}'`" ]

service advancedfiltering_smtp_exim stop || true
rm -Rvf /usr/local/etc/rc.d/advancedfiltering_smtp_exim /etc/rc.conf.d/advancedfiltering_smtp_exim /usr/local/advancedfiltering/smtp
rmuser -yv advancedfiltering_smtp || true
