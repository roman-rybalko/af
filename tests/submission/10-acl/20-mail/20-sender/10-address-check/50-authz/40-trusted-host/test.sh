#!/bin/sh -ex

. "$TESTCONF"

swaks -tls --tls-cert tests.crt --tls-key tests.key -f mbox@test.advancedfiltering.net -t test@test.com -s $DST_HOST -p submission -q mail | smtp_rj.pl | grep -E '2[[:digit:]][[:digit:]].mbox@test.advancedfiltering.net cli1 trustedhost'
