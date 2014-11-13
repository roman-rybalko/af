#!/bin/sh -ex
. ./remote.conf

pkg install -y p5-IO-Socket-SSL p5-Mail-DKIM

./mkca.sh tests-smtp-ca
mv -vf tests-smtp* /usr/local/advancedfiltering/smtp/ssl/
chown -R af_smtp:af_smtp /usr/local/advancedfiltering/smtp/ssl/tests-smtp*
