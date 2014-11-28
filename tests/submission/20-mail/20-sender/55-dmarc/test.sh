#!/bin/sh -ex
. "$TESTCONF"

swaks -f mbox@nodmarc.test.advancedfiltering.net -t test@test.com -s $DST_HOST -p submission -q mail | grep 'DMARC is absent for sender domain'
swaks -f mbox@nodmarc.test.advancedfiltering.net -t test@test.com -s $DST_HOST -p submission -q mail | grep -E ' 5[[:digit:]][[:digit:]].* nodmarc.test.advancedfiltering.net'
