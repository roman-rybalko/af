#!/bin/sh -ex
. "$TESTCONF"

# target at localhost:25
if "$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/MailBox/Check/AFsmtp<test@test.com>'; then
	false
else
	[ $? = 2 ]
fi
