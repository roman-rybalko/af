#!/bin/sh -ex
. ./remote.conf

# check group members
[ -z "`pw groupshow af_ssl | awk 'BEGIN{FS=":"}{print $4}'`" ]

rm -Rvf /usr/local/advancedfiltering/ssl /etc/advancedfiltering_ssl
pw groupdel af_ssl || true
