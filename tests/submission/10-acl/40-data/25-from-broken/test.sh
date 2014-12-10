#!/bin/sh -ex

. "$TESTCONF"

swaks -f mbox@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-From '' | grep -E '5[[:digit:]][[:digit:]].+Invalid "From:" header'
swaks -f mbox@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-From '<test@test.com>, <test2@test.com>' | grep -E '5[[:digit:]][[:digit:]].+Invalid "From:" header'
swaks -f mbox@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-From 'test@test.com, test2@test.com' | grep -E '5[[:digit:]][[:digit:]].+Invalid "From:" header'
