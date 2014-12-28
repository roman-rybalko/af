#!/bin/sh -ex

. "$TESTCONF"

sleep 1 # wait for retry time
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID mx-1
wait_file mx.mime
# DKIM-Signature
dkim_verifier mx.mime | grep advancedfiltering | grep pass
# headers
grep ^X-AdvancedFiltering-MessageData-Smtp-ViaRecipients: mx.mime
grep ^X-AdvancedFiltering-MessageData-SenderMailAddress: mx.mime
grep ^X-AdvancedFiltering-MessageData-SenderHostAddress: mx.mime
grep ^X-AdvancedFiltering-MessageData-SPFStatus: mx.mime
# DKIM
grep -E '[:=]X-AdvancedFiltering-MessageData-SenderMailAddress:' mx.mime
grep -E '[:=]X-AdvancedFiltering-MessageData-SenderHostAddress:' mx.mime
grep -E '[:=]X-AdvancedFiltering-MessageData-SPFStatus:' mx.mime
