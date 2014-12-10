#!/bin/sh -ex

. "$TESTCONF"

swaks -f mbox@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-X-AdvancedFiltering-MessageData-Submission blablabla | grep -E '5[[:digit:]][[:digit:]].+Message loop detected'
