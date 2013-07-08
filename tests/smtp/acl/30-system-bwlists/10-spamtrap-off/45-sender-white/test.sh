#!/bin/sh -ex

. "$TESTCONF"

# sender domain with no spf
swaks -f test@tests-nospf.advancedfiltering.net -t mail@unhandled.com -s $DST_HOST -q mail | grep -A1 MAIL | grep "250 OK (system policy, sender mail address)"
