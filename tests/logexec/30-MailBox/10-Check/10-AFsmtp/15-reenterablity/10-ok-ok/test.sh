#!/bin/sh -ex
. "$TESTCONF"

export AF_private_tls_cert="$TESTDIR"/.tools/tests.crt
export AF_private_tls_key="$TESTDIR"/.tools/tests.key
export AF_private_tls_ca=
"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/MailBox/Check/AFsmtp<test2@test.com> ? AdvancedFiltering/MailBox/Check/AFsmtp<test3@test.com> : AdvancedFiltering/MailBox/Check/AFsmtp<test4@test.com>'
wait_file smtp.env
grep test2@test.com smtp.env
grep test3@test.com smtp.env
! grep test4@test.com smtp.env
