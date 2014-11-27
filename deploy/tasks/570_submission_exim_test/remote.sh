#!/bin/sh -ex
. ./remote.conf
. ./pkgdep.sh

pkgdep_install submission_exim_test p5-Mail-DKIM
# p5-IO-Socket-SSL is installed by p5-perl-ldap

cp -Rvf ssl/submission-test.* /usr/local/advancedfiltering/submission/ssl/
cd ssl
./mkca.sh submission-test.ca
mv -vf submission-test.ca /usr/local/advancedfiltering/submission/ssl/
cd ..
cp -Rvf dkim/submission-test* /usr/local/advancedfiltering/submission/dkim/

chown -Rv af_submission:af_submission /usr/local/advancedfiltering/submission/ssl/submission-test*
chown -Rv af_submission:af_submission /usr/local/advancedfiltering/submission/dkim/submission-test*
