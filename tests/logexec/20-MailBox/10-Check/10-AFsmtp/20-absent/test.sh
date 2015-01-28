#!/bin/sh -ex
. "$TESTCONF"

if "$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/MailBox/Check/AFsmtp<absent@test.com>'; then
	false
else
	[ $? = 1 ]
fi
