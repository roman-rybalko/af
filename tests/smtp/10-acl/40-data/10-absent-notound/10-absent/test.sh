#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t absent@test.com -s $DST_HOST | smtp_rj.pl | grep -E "5[[:digit:]][[:digit:]].A\\|NF/ \\(Mail box does not exist\\) id="
