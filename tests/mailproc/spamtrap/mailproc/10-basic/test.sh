#!/bin/sh -ex

. "$TESTCONF"

mv .mime/* ../.mime
wait_mime_done ../.mime
match_ldif "afUSMTPMessageId=ZmQ4ZTAxY2U0YmY5JDFjOTM3OWQwJGI1NWJkMWQyQHdvcmtydQ__,afUServiceRealm=r1+afUServiceName=smtpdb,ou=user,o=advancedfiltering" \
	"^afUSMTPMessageId|afUSMTPMessageSenderMailAddress|afUSMTPMessageSpamDescription" match1.ldif
match_ldif "afUSMTPMessageId=NTFBNzVERUEuNjA1MDAwM0Bub3Zhc3BhcmtzLmNvbQ__,afUServiceRealm=r1+afUServiceName=smtpdb,ou=user,o=advancedfiltering" \
	"^afUSMTPMessageId|afUSMTPMessageSenderMailAddress|afUSMTPMessageSpamDescription" match2.ldif
