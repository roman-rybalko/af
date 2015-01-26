#!/bin/sh -ex
. "$TESTCONF"

export AF_callout_tls_data_path="`pwd`/.ssl"
"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/MailBox/Check/Callout<mbox@test.com>'
wait_file mx.env
grep mbox@test.com mx.env
grep STARTTLS mx.env
