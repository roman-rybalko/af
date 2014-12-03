#!/bin/sh -ex
. "$TESTCONF"

swaks -tls -a -au test.advancedfiltering.net -ap domainpassword -f mbox@nodmarc.test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q mail | grep ' may not use sender address'
swaks -tls -a -au test.advancedfiltering.net -ap domainpassword -f mbox@nodmarc.test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q mail | grep -E ' 5[[:digit:]][[:digit:]].* test.advancedfiltering.net'
swaks -tls -a -au test.advancedfiltering.net -ap domainpassword -f mbox@nodmarc.test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q mail | grep -E ' 5[[:digit:]][[:digit:]].* mbox@nodmarc.test.advancedfiltering.net'
