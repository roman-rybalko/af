#!/bin/sh -ex
. "$TESTCONF"

swaks -tls -a -au test.advancedfiltering.net -ap domainpassword -f mbox@test.advancedfiltering.net -t nomail@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-From mbox@test.advancedfiltering.net | smtp_rj.pl | grep -E '2[[:digit:]][[:digit:]] id=[^[:space:]]+ mbox@test.advancedfiltering.net cli1 domain'
swaks -tls -a -au test.advancedfiltering.net -ap domainpassword -f mbox@test.advancedfiltering.net -t nomail@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-From mbox@dmarc.test.advancedfiltering.net | smtp_rj.pl | grep -E '2[[:digit:]][[:digit:]] id=[^[:space:]]+ mbox@test.advancedfiltering.net cli1 domain'
swaks -tls -a -au dmarc.test.advancedfiltering.net -ap domainpassword -f mbox@test.advancedfiltering.net -t nomail@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-From mbox@test.advancedfiltering.net | smtp_rj.pl | grep -E '2[[:digit:]][[:digit:]] id=[^[:space:]]+ mbox@test.advancedfiltering.net cli1 domain'
swaks -tls -a -au dmarc.test.advancedfiltering.net -ap domainpassword -f mbox@test.advancedfiltering.net -t nomail@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-From mbox@dmarc.test.advancedfiltering.net | smtp_rj.pl | grep -E '2[[:digit:]][[:digit:]] id=[^[:space:]]+ mbox@test.advancedfiltering.net cli1 domain'
