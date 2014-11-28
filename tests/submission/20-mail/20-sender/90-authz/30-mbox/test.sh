#!/bin/sh -ex
. "$TESTCONF"

swaks -tls -a -au mbox@test.advancedfiltering.net -ap mailboxpassword -f mbox2@test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q mail | grep ' may not use'
swaks -tls -a -au mbox@test.advancedfiltering.net -ap mailboxpassword -f mbox2@test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q mail | grep -E ' 5[[:digit:]][[:digit:]].* mbox@test.advancedfiltering.net'
swaks -tls -a -au mbox@test.advancedfiltering.net -ap mailboxpassword -f mbox2@test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q mail | grep -E ' 5[[:digit:]][[:digit:]].* mbox2@test.advancedfiltering.net'
