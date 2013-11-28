#!/bin/sh -ex
. "$TESTCONF"

wait_mime_done()
{
	cnt=50
	while [ $cnt -gt 0 ]
	do
		exists=
		for f in .mime/*.mime
		do
			[ -e $f ] || break
			exists=1
		done
		[ -n "$exists" ] || break
		cnt=$(($cnt-1))
		usleep 100000
	done
	[ $cnt -gt 0 ]
}

./mailproc.sh -l -v 3 &
# -d all
pid=$!

./mailproc.sh -l -v 3 &
# -d all
pid=$!


cp -v ../.init/*/*.mime .mime
mime_add_hdr.sh sender@tests.advancedfintering.net recipient@tests.advancedfiltering.net r1 .mime/*.mime
match_ldif "afUSMTPMessageId=ZmQ4ZTAxY2U0YmY5JDFjOTM3OWQwJGI1NWJkMWQyQHdvcmtydQ__,afUServiceRealm=r1+afUServiceName=smtpdb,ou=user,o=advancedfiltering" \
	"^afUSMTPMessageId|afUSMTPMessageSenderMailAddress|afUSMTPMessageSpamDescription" match1.ldif
match_ldif "afUSMTPMessageId=NTFBNzVERUEuNjA1MDAwM0Bub3Zhc3BhcmtzLmNvbQ__,afUServiceRealm=r1+afUServiceName=smtpdb,ou=user,o=advancedfiltering" \
	"^afUSMTPMessageId|afUSMTPMessageSenderMailAddress|afUSMTPMessageSpamDescription" match2.ldif
wait_mime_done

cp -v ../.init/*/*.mime .mime
wait_mime_done

del_ldap user-clean.sh
cp -v ../.init/*/*.mime .mime
match_ldif "afUSMTPMessageId=ZmQ4ZTAxY2U0YmY5JDFjOTM3OWQwJGI1NWJkMWQyQHdvcmtydQ__,afUServiceRealm=r1+afUServiceName=smtpdb,ou=user,o=advancedfiltering" \
	"^afUSMTPMessageId|afUSMTPMessageSenderMailAddress|afUSMTPMessageSpamDescription" match1.ldif
match_ldif "afUSMTPMessageId=NTFBNzVERUEuNjA1MDAwM0Bub3Zhc3BhcmtzLmNvbQ__,afUServiceRealm=r1+afUServiceName=smtpdb,ou=user,o=advancedfiltering" \
	"^afUSMTPMessageId|afUSMTPMessageSenderMailAddress|afUSMTPMessageSpamDescription" match2.ldif
wait_mime_done

cnt=50
while [ $cnt -gt 0 ]
do
	kill -0 $pid || break
	cnt=$(($cnt-1))
	usleep 100000
done
kill $pid || true
kill -9 $pid || true
[ $cnt -gt 0 ]
