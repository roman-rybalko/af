#!/bin/sh -ex

. "$TESTCONF"

rm -f submission1.mime
start_server submission -s 1 -m submission1.mime -p 16025
swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST --h-Message-ID message-loop-1
wait_file submission1.mime
dkim_verifier submission1.mime | grep advancedfiltering | grep pass
stop_server submission

swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST -d submission1.mime | grep "Message loop detected" | grep mbox2@test.com
