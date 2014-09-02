#!/bin/sh -ex
. ./remote.conf

pkg install p5-IO-Socket-SSL

mkca.sh tests-smtp-ca
mv -vf tests-smtp* /usr/local/advancedfiltering/smtp/ssl/
chown -R advancedfiltering_smtp:advancedfiltering_smtp /usr/local/advancedfiltering/smtp/ssl/tests-smtp*
