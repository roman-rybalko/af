#!/bin/sh -ex
. "$TESTCONF"

! get_ldif "afUSMTPMessageId=testmid,afUServiceName=smtpdb+afUServiceRealm=r1,ou=user,o=advancedfiltering" \
"^afUSMTPMessageSenderMailAddress|^afUSMTPMessageId" 1.ldif

"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/MessageID/smtpdb/Add<r1><testmid><test@test.com><test descr>'

match_ldif "afUSMTPMessageId=testmid,afUServiceName=smtpdb+afUServiceRealm=r1,ou=user,o=advancedfiltering" \
"^afUSMTPMessageSenderMailAddress|^afUSMTPMessageId|^afUSMTPMessageSpamDescription" match.ldif
