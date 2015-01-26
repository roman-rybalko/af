#!/bin/sh -ex
. "$TESTCONF"

! get_ldif "afUSMTPMessageId=testmid,afUServiceName=submissiondb+afUServiceRealm=r1,ou=user,o=advancedfiltering" \
"^afUSMTPMessageSenderMailAddress|^afUSMTPMessageId" 1.ldif

"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/MessageID/submissiondb/Add<r1><testmid><test@test.com>'

match_ldif "afUSMTPMessageId=testmid,afUServiceName=submissiondb+afUServiceRealm=r1,ou=user,o=advancedfiltering" \
"^afUSMTPMessageSenderMailAddress|^afUSMTPMessageId" match.ldif
