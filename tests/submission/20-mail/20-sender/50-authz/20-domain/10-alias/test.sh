#!/bin/sh -ex
. "$TESTCONF"

swaks -tls -a -au test.advancedfiltering.net -ap domainpassword -f mbox@test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q mail | grep -E '2[[:digit:]][[:digit:]].mbox@test.advancedfiltering.net cli1 domain'
swaks -tls -a -au test.advancedfiltering.net -ap domainpassword -f mbox@dmarc.test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q mail | grep -E '2[[:digit:]][[:digit:]].mbox@test.advancedfiltering.net cli1 domain'
swaks -tls -a -au dmarc.test.advancedfiltering.net -ap domainpassword -f mbox@test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q mail | grep -E '2[[:digit:]][[:digit:]].mbox@test.advancedfiltering.net cli1 domain'
swaks -tls -a -au dmarc.test.advancedfiltering.net -ap domainpassword -f mbox@dmarc.test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q mail | grep -E '2[[:digit:]][[:digit:]].mbox@test.advancedfiltering.net cli1 domain'
