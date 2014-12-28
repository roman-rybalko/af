#!/bin/sh -ex

. "$TESTCONF"

swaks -f mbox@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-X-AdvancedFiltering-MessageData-Submission-ViaRecipients test@dmarc.test.advancedfiltering.net | smtp_rj.pl |  grep -E '5[[:digit:]][[:digit:]].+Message loop detected'
swaks -f mbox@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-X-AdvancedFiltering-MessageData-Submission-ViaRecipients 'test@test.com test@dmarc.test.advancedfiltering.net test@test.com' | smtp_rj.pl | grep -E '5[[:digit:]][[:digit:]].+Message loop detected'
