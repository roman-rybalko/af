#!/bin/sh -ex

. "$TESTCONF"

while true; do
    stop_server mailproc
    rm -f mailproc.env
    start_server mailproc -s 1 -p 21025 -e mailproc.env
    swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID mailproc-1 || true
    wait_file mailproc.env
    [ ! -e mailproc_notls.env ] || break
done
if grep MAIL mailproc_notls.env; then
    false
else
    true
fi
grep MAIL mailproc.env
