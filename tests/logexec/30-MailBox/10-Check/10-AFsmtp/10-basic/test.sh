#!/bin/sh -ex
. "$TESTCONF"

export AF_private_tls_cert="$TESTDIR"/.tools/tests.crt
export AF_private_tls_key="$TESTDIR"/.tools/tests.key
export AF_private_tls_ca=
"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/MailBox/Check/AFsmtp<test@test.com>'
wait_file smtp.env
grep -i CN=tests smtp.env
