#!/bin/sh -ex
. "$TESTCONF"

swaks -tls -a -au cli1 -ap clientpassword -f mbox@nodmarc.test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q mail | grep ' may not use sender address'
swaks -tls -a -au cli1 -ap clientpassword -f mbox@nodmarc.test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q mail | grep -E ' 5[[:digit:]][[:digit:]].* cli1'
swaks -tls -a -au cli1 -ap clientpassword -f mbox@nodmarc.test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q mail | grep -E ' 5[[:digit:]][[:digit:]].* mbox@nodmarc.test.advancedfiltering.net'
