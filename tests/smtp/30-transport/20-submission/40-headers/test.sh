#!/bin/sh -ex

. "$TESTCONF"

sleep 1 # wait for retry time
swaks -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID submission-1 || true
wait_file submission.mime
# DKIM-Signature
dkim_verifier submission.mime | grep advancedfiltering | grep pass
# headers
grep ^X-AdvancedFiltering-MessageData-ViaRecipients: submission.mime
grep ^X-AdvancedFiltering-MessageData-SenderMailAddress: submission.mime
grep ^X-AdvancedFiltering-MessageData-SenderHostAddress: submission.mime
grep ^X-AdvancedFiltering-MessageData-SPFStatus: submission.mime
# DKIM
grep -E '[:=]X-AdvancedFiltering-MessageData-SenderMailAddress:' submission.mime
grep -E '[:=]X-AdvancedFiltering-MessageData-SenderHostAddress:' submission.mime
grep -E '[:=]X-AdvancedFiltering-MessageData-SPFStatus:' submission.mime
