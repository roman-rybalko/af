#!/bin/sh -ex

. "$TESTCONF"

swaks -tls --tls-cert tests.crt --tls-key tests.key -f mbox2@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission
wait_file ss.env
wait_file mp.env
grep spamsender ss.env
! grep mbox2@ ss.env
! grep test@ ss.env
grep mbox2@ ss.mime | grep Envelope
grep test@ ss.mime | grep Envelope
grep MessageData-Submission-ViaRecipients ss.mime
