#!/bin/sh -ex
. ./remote.conf
. ./pkgdep.sh

# check group members
[ -z "`pw groupshow af_smtp | awk 'BEGIN{FS=":"}{print $4}'`" ]

service advancedfiltering_smtp_exim stop || true
exim -C /usr/local/advancedfiltering/smtp/exim/main.conf -qff || true
exim -C /usr/local/advancedfiltering/smtp/exim/shutdown.conf -qff || true
if [ -n "`exim -C /usr/local/advancedfiltering/smtp/exim/shutdown.conf -bp`" ]; then
	service advancedfiltering_smtp_exim start
	exit 1
fi
rmuser -yv af_smtp || true  # before rm
rm -Rvf /usr/local/etc/rc.d/advancedfiltering_smtp_exim /etc/rc.conf.d/advancedfiltering_smtp_exim /usr/local/advancedfiltering/smtp

./db-mod.sh || true

pkgdep_uninstall smtp_exim exim p5-perl-ldap p5-Net-DNS
