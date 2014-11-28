#!/bin/sh -ex
. "$TESTCONF"

swaks -f mbox@testalias.test.advancedfiltering.net -t test@test.com -s $DST_HOST -p submission -q mail | grep 'DMARC is absent'
