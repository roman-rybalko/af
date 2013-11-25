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
export AFSMTP_CAPATH=.tests-ca
"$TESTDIR"/test-afsmtp.pl
wait_file server.env
grep CN=tests-smtp server.env
grep dGVzdAB0ZXN0AHRlc3Q= server.env
grep 'FROM:<test-from@hosts.advancedfiltering.net' server.env
grep 'TO:<test-to@hosts.advancedfiltering.net' server.env
