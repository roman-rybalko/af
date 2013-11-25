#!/bin/sh -ex
. "$TESTCONF"
export AFSMTP_HOST=localhost
export AFSMTP_PORT=25251
export AFSMTP_USER=test
export AFSMTP_PASS=test
export AFSMTP_FROM=test-from@hosts.advancedfiltering.net
export AFSMTP_TO=test-to@hosts.advancedfiltering.net
export AFSMTP_CERT=tests-smtp.crt
export AFSMTP_KEY=tests-smtp.key
export AFSMTP_PATH=tests-ca
"$TESTDIR"/test-afsmtp.pl
