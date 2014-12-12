#!/bin/sh -ex

. "$TESTCONF"

swaks -f mbox@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-Reply-To '' | grep -E '5[[:digit:]][[:digit:]] Invalid "Reply-To:" header'
swaks -f mbox@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-Reply-To '<test@test.com>, <test2@test.com>' | grep -E '5[[:digit:]][[:digit:]] Invalid "Reply-To:" header'
swaks -f mbox@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-Reply-To 'test@test.com, test2@test.com' | grep -E '5[[:digit:]][[:digit:]] Invalid "Reply-To:" header'
