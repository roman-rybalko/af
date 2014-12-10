#!/bin/sh -ex

. "$TESTCONF"

swaks -f mbox@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-Cc 'тест юникод utf8' | grep -E '5[[:digit:]][[:digit:]].+Invalid message headers'
swaks -f mbox@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-From blablabla | grep -E '5[[:digit:]][[:digit:]].+Invalid message headers'
swaks -f mbox@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-From '1 2 3' | grep -E '5[[:digit:]][[:digit:]].+Invalid message headers'
