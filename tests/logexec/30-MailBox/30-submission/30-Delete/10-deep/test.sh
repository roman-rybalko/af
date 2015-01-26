#!/bin/sh -ex
. "$TESTCONF"

get_ldif "afUSubmissionDMBLocalPart=test,afUSubmissionDomainName=test.com,\
afUClientName=cli1,afUServiceRealm=r1+afUServiceName=submission,ou=user,o=advancedfiltering" \
"^afUSubmissionDMBLocalPart" 1.ldif

"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/MailBox/submission/Delete<test@test.com>'

! get_ldif "afUSubmissionDMBLocalPart=test,afUSubmissionDomainName=test.com,\
afUClientName=cli1,afUServiceRealm=r1+afUServiceName=submission,ou=user,o=advancedfiltering" \
"^afUSubmissionDMBLocalPart" 2.ldif
