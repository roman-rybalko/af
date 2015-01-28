#!/bin/sh -ex
. ./remote.conf
. ./pkgdep.sh

pkgdep_install smtp_exim_test p5-Mail-DKIM
# p5-IO-Socket-SSL is installed by p5-perl-ldap

./mkca.sh tests-smtp-ca
mv -vf tests-smtp* /usr/local/advancedfiltering/smtp/ssl/
chown -R af_smtp:af_smtp /usr/local/advancedfiltering/smtp/ssl/tests-smtp*
