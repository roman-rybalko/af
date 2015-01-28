#!/bin/sh -ex
. ./remote.conf
. ./pkgdep.sh

# check group members
[ -z "`pw groupshow af_smtp | awk 'BEGIN{FS=":"}{print $4}'`" ]

service advancedfiltering_smtp_exim stop || true
rmuser -yv af_smtp || true  # before rm
rm -Rvf /usr/local/etc/rc.d/advancedfiltering_smtp_exim /etc/rc.conf.d/advancedfiltering_smtp_exim /usr/local/advancedfiltering/smtp

./db-mod.sh || true

pkgdep_uninstall smtp_exim exim p5-perl-ldap p5-Net-DNS
