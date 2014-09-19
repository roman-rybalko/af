#!/bin/sh -ex

. "$TESTCONF"

while true; do
    stop_server submission
    rm -f submission.env
    start_server submission -s 1 -p 26025 -e submission.env
    swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID submission-1 || true
    wait_file submission.env
    [ ! -e submission_notls.env ] || break
done
if grep MAIL submission_notls.env; then
    false
else
    true
fi
grep MAIL submission.env
