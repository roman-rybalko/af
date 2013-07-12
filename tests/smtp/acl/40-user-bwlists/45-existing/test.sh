#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@advancedfiltering.net -t existing@test.com -s $DST_HOST -q rcpt | grep -A1 RCPT | grep "250.Accepted"
