#!/bin/sh -ex
. ./remote.conf
. ./pkgdep.sh

pkgdep_install submission_exim_test p5-IO-Socket-SSL p5-Mail-DKIM

cp -Rvf ssl/tests-submission* /usr/local/advancedfiltering/submission/ssl/
cp -Rvf dkim/tests-submission* /usr/local/advancedfiltering/submission/dkim/

chown -R af_submission:af_submission /usr/local/advancedfiltering/submission/ssl/tests-submission*
chown -R af_submission:af_submission /usr/local/advancedfiltering/submission/dkim/tests-submission*
