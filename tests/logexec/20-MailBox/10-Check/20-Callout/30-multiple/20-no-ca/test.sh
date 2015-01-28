#!/bin/sh -ex
. "$TESTCONF"

export AF_callout_tls_data_path="`pwd`/.ssl"
cnt=10
while [ ! -e mx1.env ]; do
	"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/MailBox/Check/Callout<mbox@test.com>'
	cnt=$(($cnt-1))
	[ $cnt -gt 0 ]
done
