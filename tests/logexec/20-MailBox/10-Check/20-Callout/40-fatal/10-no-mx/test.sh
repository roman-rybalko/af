#!/bin/sh -ex
. "$TESTCONF"

if "$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/MailBox/Check/Callout<mbox@test.com>'; then
	false
else
	[ $? = 2 ]
fi
