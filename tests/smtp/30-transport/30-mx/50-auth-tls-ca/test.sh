#!/bin/sh -ex

. "$TESTCONF"

while true; do
    stop_server mx2
    rm -f mx2.env
    start_server mx2 -s 1 -p 22525 -e mx2.env
    swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID mx-1
    wait_file mx2.env
    [ ! -e mx.env ] || break
done
if grep MAIL mx.env; then
    false
else
    true
fi
grep CN=tests-smtp mx2.env
grep MAIL mx2.env
