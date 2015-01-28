#!/bin/sh -ex
. "$TESTCONF"

"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/MailBox/smtp/Enable<test@test.com>'

match_ldif "afUSMTPDMBLocalPart=test,afUSMTPDomainName=test.com,\
afUClientName=cli1,afUServiceRealm=r1+afUServiceName=smtp,ou=user,o=advancedfiltering" \
"^afUSMTPDMBLocalPart" match.ldif
