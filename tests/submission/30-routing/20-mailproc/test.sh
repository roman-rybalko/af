#!/bin/sh -ex

. "$TESTCONF"

swaks -tls --tls-cert tests.crt --tls-key tests.key -f mbox@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission
wait_file mp.env
wait_file mx.env
grep mailproc mp.env
! grep mbox@ mp.env
! grep test@ mp.env
grep mbox@ mp.mime | grep Envelope
grep test@ mp.mime | grep Envelope
