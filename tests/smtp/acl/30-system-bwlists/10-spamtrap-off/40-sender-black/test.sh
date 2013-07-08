#!/bin/sh -ex

. "$TESTCONF"

# spf should fail
swaks -f test@mcafee.com -t mail@unhandled.com -s $DST_HOST -q mail | grep "550 Access denied (system policy, sender mail address)"