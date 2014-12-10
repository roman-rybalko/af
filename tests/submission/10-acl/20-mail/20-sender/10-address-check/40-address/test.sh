#!/bin/sh -ex
. "$TESTCONF"

swaks -f mbox2@test.advancedfiltering.net -t test@test.com -s $DST_HOST -p submission -q mail | smtp_rj.pl | grep -E '5[[:digit:]][[:digit:]] Envelope-From address mbox2@test.advancedfiltering.net does not exist'
swaks -f mbox2@nodmarc.test.advancedfiltering.net -t test@test.com -s $DST_HOST -p submission -q mail | smtp_rj.pl | grep -E '5[[:digit:]][[:digit:]] Envelope-From address mbox2@nodmarc.test.advancedfiltering.net \(alias to test.advancedfiltering.net\) does not exist'
