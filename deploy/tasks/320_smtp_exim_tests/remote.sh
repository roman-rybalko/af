#!/bin/sh -ex
. ./remote.conf

cp -Rfv tests-smtp* /usr/local/advancedfiltering/smtp/ssl/
chown -R advancedfiltering_smtp:advancedfiltering_smtp /usr/local/advancedfiltering/smtp/ssl/tests-smtp*
