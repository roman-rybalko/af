#!/bin/sh -ex
. "$TESTCONF"

swaks -f mbox@test.advancedfiltering.net -t test@nomail.test.advancedfiltering.net -s $DST_HOST -p submission -q rcpt | grep 'Recipient domain'
swaks -f mbox@test.advancedfiltering.net -t test@nomail.test.advancedfiltering.net -s $DST_HOST -p submission -q rcpt | grep 'nomail.test.advancedfiltering.net'
swaks -f mbox@test.advancedfiltering.net -t test@nomail.test.advancedfiltering.net -s $DST_HOST -p submission -q rcpt | grep 'does not accept mail'
