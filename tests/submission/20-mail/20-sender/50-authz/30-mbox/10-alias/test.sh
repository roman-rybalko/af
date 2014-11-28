#!/bin/sh -ex
. "$TESTCONF"

swaks -tls -a -au mbox@test.advancedfiltering.net -ap mailboxpassword -f mbox@test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q mail | grep -E '2[[:digit:]][[:digit:]].mbox@test.advancedfiltering.net cli1 mbox'
swaks -tls -a -au mbox@test.advancedfiltering.net -ap mailboxpassword -f mbox@authzalias.test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q mail | grep -E '2[[:digit:]][[:digit:]].mbox@test.advancedfiltering.net cli1 mbox'
swaks -tls -a -au mbox@authzalias.test.advancedfiltering.net -ap mailboxpassword -f mbox@test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q mail | grep -E '2[[:digit:]][[:digit:]].mbox@test.advancedfiltering.net cli1 mbox'
swaks -tls -a -au mbox@authzalias.test.advancedfiltering.net -ap mailboxpassword -f mbox@authzalias.test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q mail | grep -E '2[[:digit:]][[:digit:]].mbox@test.advancedfiltering.net cli1 mbox'
