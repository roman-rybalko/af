#!/bin/sh -ex
. "$TESTCONF"

"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/MailBox/Check/AFsmtp<test@test.com>'
"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/MailBox/Check/AFsmtp<test2@test.com>'
