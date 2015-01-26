#!/bin/sh -ex
. "$TESTCONF"

cnt=10
while [ ! -e mx1.env ]; do
	"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/MailBox/Check/Callout<mbox@test.com>'
	cnt=$(($cnt-1))
	[ $cnt -gt 0 ]
done
