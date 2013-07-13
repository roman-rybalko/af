#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mail@a-domain-that-not-in-service.com -s $DST_HOST -q rcpt | grep -A1 RCPT | grep "550 The domain is not in service"
