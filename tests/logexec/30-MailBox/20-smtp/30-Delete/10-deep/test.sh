#!/bin/sh -ex
. "$TESTCONF"

get_ldif "afUSMTPDMBLocalPart=test,afUSMTPDomainName=test.com,\
afUClientName=cli1,afUServiceRealm=r1+afUServiceName=smtp,ou=user,o=advancedfiltering" \
"^afUSMTPDMBLocalPart" 1.ldif

"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/MailBox/smtp/Delete<test@test.com>'

! get_ldif "afUSMTPDMBLocalPart=test,afUSMTPDomainName=test.com,\
afUClientName=cli1,afUServiceRealm=r1+afUServiceName=smtp,ou=user,o=advancedfiltering" \
"^afUSMTPDMBLocalPart" 2.ldif
