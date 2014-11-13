#!/bin/sh -ex
. ./remote.conf
. ./pkgdep.sh

# check group members
[ -z "`pw groupshow advancedfiltering_submission | awk 'BEGIN{FS=":"}{print $4}'`" ]

service advancedfiltering_submission_exim stop || true
rm -Rvf /usr/local/etc/rc.d/advancedfiltering_submission_exim /etc/rc.conf.d/advancedfiltering_submission_exim /usr/local/advancedfiltering/submission
rmuser -yv advancedfiltering_submission || true

./db-mod.sh || true

pkgdep_uninstall submission_exim exim p5-perl-ldap
