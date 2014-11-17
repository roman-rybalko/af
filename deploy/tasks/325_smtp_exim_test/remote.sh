#!/bin/sh -ex
. ./remote.conf
. ./pkgdep.sh

pkgdep_install smtp_exim_test p5-IO-Socket-SSL p5-Mail-DKIM

./mkca.sh tests-smtp-ca
mv -vf tests-smtp* /usr/local/advancedfiltering/smtp/ssl/
chown -R af_smtp:af_smtp /usr/local/advancedfiltering/smtp/ssl/tests-smtp*
