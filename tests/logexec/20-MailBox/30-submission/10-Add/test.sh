#!/bin/sh -ex
. "$TESTCONF"

"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/MailBox/submission/Add<test@test.com>'

match_ldif "afUSubmissionDMBLocalPart=test,afUSubmissionDomainName=test.com,\
afUClientName=cli1,afUServiceRealm=r1+afUServiceName=submission,ou=user,o=advancedfiltering" \
"^afUSubmissionDMBLocalPart" match.ldif
