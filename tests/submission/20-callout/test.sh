#!/bin/sh -ex
. "$TESTCONF"

swaks -tls --tls-cert tests.crt --tls-key tests.key -f mbox@test.advancedfiltering.net -t test@test.com -s $DST_HOST -p submission -q mail
wait_file smtp.env
grep mbox@test.advancedfiltering.net smtp.env
wait_ldif_add user2.ldif
