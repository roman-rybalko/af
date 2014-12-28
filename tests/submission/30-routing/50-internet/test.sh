#!/bin/sh -ex

. "$TESTCONF"

swaks -tls --tls-cert tests.crt --tls-key tests.key -f mbox@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission
wait_file mp.env
wait_file mx.env
grep mbox@ mx.env
grep test@ mx.env
grep mbox@ mx.mime
grep test@ mx.mime
grep -i DKIM-Signature mx.mime
grep MessageData-Submission-ViaRecipients mx.mime
grep -i Message-Id mx.mime
