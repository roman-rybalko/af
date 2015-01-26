#!/bin/sh -ex
. "$TESTCONF"

"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/MailBox/Check/Callout<mbox@test.com>'
wait_file mx.env
grep mbox@test.com mx.env
