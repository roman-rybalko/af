#!/bin/sh -ex
. "$TESTCONF"

if "$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/MailBox/Check/AFsmtp<test@test2.com>'; then
	false
else
	[ $? = 2 ]
fi
