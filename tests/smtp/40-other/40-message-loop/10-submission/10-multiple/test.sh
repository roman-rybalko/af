#!/bin/sh -ex

. "$TESTCONF"

rm -f submission1.mime
start_server submission -s 1 -m submission1.mime -p 16025
swaks -f test@tests.advancedfiltering.net -t mbox3@test.com -s $DST_HOST --h-Message-ID message-loop-2
wait_file submission1.mime
dkim_verifier submission1.mime | grep advancedfiltering | grep pass
stop_server submission

rm -f submission2.mime
start_server submission -s 1 -m submission2.mime -p 16025
swaks -f test@tests.advancedfiltering.net -t mbox4@test.com -s $DST_HOST -d submission1.mime
wait_file submission2.mime
dkim_verifier submission2.mime | grep advancedfiltering | grep pass
stop_server submission

rm -f submission1.mime
start_server submission -s 1 -m submission1.mime -p 16025
swaks -f test@tests.advancedfiltering.net -t mbox3@test.com -s $DST_HOST -d submission2.mime
wait_file submission1.mime
dkim_verifier submission1.mime | grep advancedfiltering | grep pass
stop_server submission

swaks -f test@tests.advancedfiltering.net -t mbox4@test.com -s $DST_HOST -d submission1.mime | grep "Message loop detected" | grep mbox3@test.com | grep mbox4@test.com
