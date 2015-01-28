#!/bin/sh -ex
. ./remote.conf
. ./pkgdep.sh

rm -Rvf /usr/local/advancedfiltering/smtp/ssl/tests-smtp*
pkgdep_uninstall smtp_exim_test p5-Mail-DKIM
