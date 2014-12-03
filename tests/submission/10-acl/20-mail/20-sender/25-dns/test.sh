#!/bin/sh -ex
. "$TESTCONF"

swaks -f mbox@nomail.test.advancedfiltering.net -t test@test.com -s $DST_HOST -p submission -q mail | grep 'does not accept mail'
