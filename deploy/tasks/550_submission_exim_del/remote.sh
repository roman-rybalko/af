#!/bin/sh -ex
. ./remote.conf
. ./pkgdep.sh

# check group members
[ -z "`pw groupshow af_submission | awk 'BEGIN{FS=":"}{print $4}'`" ]

service advancedfiltering_submission_exim stop || true
exim -C /usr/local/advancedfiltering/submission/exim/main.conf -qff || true
exim -C /usr/local/advancedfiltering/submission/exim/shutdown.conf -qff || true
if [ -n "`exim -C /usr/local/advancedfiltering/submission/exim/shutdown.conf -bp`" ]; then
	service advancedfiltering_submission_exim start
	exit 1
fi
rmuser -yv af_submission || true  # before rm
rm -Rvf /usr/local/etc/rc.d/advancedfiltering_submission_exim /etc/rc.conf.d/advancedfiltering_submission_exim /usr/local/advancedfiltering/submission

./db-mod.sh || true

pkgdep_uninstall submission_exim exim p5-perl-ldap p5-Net-DNS
