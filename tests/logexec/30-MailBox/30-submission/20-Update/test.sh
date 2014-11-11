#!/bin/sh -ex
. "$TESTCONF"

get_ldif "afUSubmissionDMBLocalPart=test,afUSubmissionDomainName=test.com,\
afUClientName=cli1,afUServiceRealm=r1+afUServiceName=submission,ou=user,o=advancedfiltering" \
"^afUSubmissionDMBTimeUpdated" 1.ldif

"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/MailBox/submission/Update<test@test.com>'

get_ldif "afUSubmissionDMBLocalPart=test,afUSubmissionDomainName=test.com,\
afUClientName=cli1,afUServiceRealm=r1+afUServiceName=submission,ou=user,o=advancedfiltering" \
"^afUSubmissionDMBTimeUpdated" 2.ldif

! diff -u 1.ldif 2.ldif
