#!/bin/sh -ex
. ./remote.conf

# check group members
[ -z "`pw groupshow advancedfiltering_ssl | awk 'BEGIN{FS=":"}{print $4}'`" ]

rm -Rvf /usr/local/advancedfiltering/ssl /etc/advancedfiltering_ssl
pw groupdel advancedfiltering_ssl || true
