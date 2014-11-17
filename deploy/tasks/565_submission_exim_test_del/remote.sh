#!/bin/sh -ex
. ./remote.conf
. ./pkgdep.sh

rm -Rvf /usr/local/advancedfiltering/submission/ssl/tests-submission*
rm -Rvf /usr/local/advancedfiltering/submission/dkim/tests-submission*
pkgdep_uninstall submission_exim_test p5-IO-Socket-SSL p5-Mail-DKIM
