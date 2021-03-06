#!/bin/sh -ex
. "$TESTCONF"

"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/MailBox/smtp/Disable<test@test.com>'

match_ldif "afUSMTPDMBLocalPart=test,afUSMTPDomainName=test.com,\
afUClientName=cli1,afUServiceRealm=r1+afUServiceName=smtp,ou=user,o=advancedfiltering" \
"^afUSMTPDMBLocalPart" match1.ldif
match_ldif "afUSMTPDMBLocalPart=test,afUSMTPDomainName=test.com,\
afUClientName=cli1,afUServiceRealm=r1+afUServiceName=smtp,ou=user,o=advancedfiltering" \
"^afUSMTPDMBIsAbsent" match2.ldif
