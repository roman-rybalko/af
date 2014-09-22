#!/bin/sh -ex

. "$TESTCONF"

rm -f mx1.mime
start_server mx -s 1 -m mx1.mime -p 2525
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID message-loop-mx-1
wait_file mx1.mime
dkim_verifier mx1.mime | grep advancedfiltering | grep pass
stop_server mx

sed -i .orig -r 's/ bh=[^;]+;/ bh=xxxxxxx;/' mx1.mime
rm -f mx1.mime.orig

rm -f mx2.mime
start_server mx -s 1 -m mx2.mime -p 2525
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST -d mx1.mime
wait_file mx2.mime
dkim_verifier mx2.mime | grep advancedfiltering | grep pass
stop_server mx

grep ^X-AdvancedFiltering-Via-Recipients: mx2.mime | grep -v -E "mbox@test.com[[:space:]]+mbox@test.com"
