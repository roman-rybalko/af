#!/bin/sh -ex
. "$TESTCONF"
export AFSMTP_HOST=smtp.gmail.com
export AFSMTP_PORT=587
export AFSMTP_USER=advancedfilteringtest@gmail.com
export AFSMTP_PASS=advancedfilteringtest1
export AFSMTP_FROM=test@test.com
export AFSMTP_TO=advancedfilteringtest@gmail.com
export AFSMTP_CERT=tests-smtp.crt
export AFSMTP_KEY=tests-smtp.key
"$TESTDIR"/test-afsmtp.pl
