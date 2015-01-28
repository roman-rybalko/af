#!/bin/sh -ex
. "$TESTCONF"

get_ldif "afUSMTPMessageId=testmid2,afUServiceName=smtpdb+afUServiceRealm=r1,ou=user,o=advancedfiltering" \
"^afUSMTPMessageSenderMailAddress|^afUSMTPMessageId" 1.ldif

"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/MessageID/smtpdb/Delete<r1><testmid2>'

! get_ldif "afUSMTPMessageId=testmid2,afUServiceName=smtpdb+afUServiceRealm=r1,ou=user,o=advancedfiltering" \
"^afUSMTPMessageSenderMailAddress|^afUSMTPMessageId" 2.ldif
