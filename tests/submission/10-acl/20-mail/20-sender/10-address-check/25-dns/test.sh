#!/bin/sh -ex
. "$TESTCONF"

swaks -f mbox@nomail.test.advancedfiltering.net -t test@test.com -s $DST_HOST -p submission -q mail | smtp_rj.pl | grep -E '5[[:digit:]][[:digit:]] Envelope-From domain nomail.test.advancedfiltering.net does not accept mail'
