#!/bin/sh -ex
. "$TESTCONF"

swaks -f mbox@test.advancedfiltering.net -t nomail@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-From mbox2@test.advancedfiltering.net | smtp_rj.pl | grep -E '5[[:digit:]][[:digit:]] "From:" address mbox2@test.advancedfiltering.net does not exist'
swaks -f mbox@test.advancedfiltering.net -t nomail@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-From mbox2@nodmarc.test.advancedfiltering.net | smtp_rj.pl | grep -E '5[[:digit:]][[:digit:]] "From:" address mbox2@nodmarc.test.advancedfiltering.net \(alias to test.advancedfiltering.net\) does not exist'
