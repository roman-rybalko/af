#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@advancedfiltering.net -t mail@unhandled.com -s $DST_HOST -q mail | grep -A1 MAIL | grep "OK (system policy, sender host name)"
