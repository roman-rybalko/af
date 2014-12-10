#!/bin/sh -ex

. "$TESTCONF"

swaks -tls --tls-cert tests.crt --tls-key tests.key -f mbox@test.advancedfiltering.net -t nomail@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-From mbox2@test.advancedfiltering.net | smtp_rj.pl | grep -E '2[[:digit:]][[:digit:]] id=[^[:space:]]+ mbox2@test.advancedfiltering.net cli1 trustedhost'
