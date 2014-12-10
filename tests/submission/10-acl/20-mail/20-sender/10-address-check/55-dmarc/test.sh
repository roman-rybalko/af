#!/bin/sh -ex
. "$TESTCONF"

swaks -f mbox@nodmarc.test.advancedfiltering.net -t test@test.com -s $DST_HOST -p submission -q mail | smtp_rj.pl | grep -E '5[[:digit:]][[:digit:]] DMARC is absent for Envelope-From domain nodmarc.test.advancedfiltering.net \(.+\)'
