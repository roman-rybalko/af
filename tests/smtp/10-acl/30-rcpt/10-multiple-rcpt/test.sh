#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t existing@test.com,test@test.com -s $DST_HOST -q rcpt | grep -E "4[[:digit:]][[:digit:]].RC/ \\(Mail box is temporarily unavailable"
