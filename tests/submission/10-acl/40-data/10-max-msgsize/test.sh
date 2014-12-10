#!/bin/sh -ex

. "$TESTCONF"

swaks -f mbox@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --body system-mms-init.ldif | grep 'SIZE 128'
swaks -f mbox@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --body system-mms-init.ldif | grep -E '5[[:digit:]][[:digit:]].+Message size'
