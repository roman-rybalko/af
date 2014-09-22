#!/bin/sh -ex

. "$TESTCONF"

rm -f mx1.mime
start_server mx -s 1 -m mx1.mime -p 2525
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID message-loop-mx-1
wait_file mx1.mime
dkim_verifier mx1.mime | grep advancedfiltering | grep pass
stop_server mx

rm -f mx2.mime
start_server mx -s 1 -m mx2.mime -p 2525
swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST -d mx1.mime
wait_file mx2.mime
dkim_verifier mx2.mime | grep advancedfiltering | grep pass
stop_server mx

rm -f mx1.mime
start_server mx -s 1 -m mx1.mime -p 2525
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -d mx2.mime
wait_file mx1.mime
dkim_verifier mx1.mime | grep advancedfiltering | grep pass
stop_server mx

swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST -d mx1.mime | grep "Message loop detected" | grep mbox@test.com | grep mbox2@test.com
