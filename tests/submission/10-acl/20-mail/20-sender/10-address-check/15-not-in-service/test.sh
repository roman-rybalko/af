#!/bin/sh -ex
. "$TESTCONF"

swaks -f mbox@testxxx.advancedfiltering.net -t test@test.com -s $DST_HOST -p submission -q mail | smtp_rj.pl | grep -E '5[[:digit:]][[:digit:]] Envelope-From domain testxxx.advancedfiltering.net is not in service'
