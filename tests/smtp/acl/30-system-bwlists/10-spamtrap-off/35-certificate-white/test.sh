#!/bin/sh -ex

. "$TESTCONF"

swaks -tls --tls-cert tests-bwlist.crt --tls-key tests-bwlist.key -f test@advancedfiltering.net -t mail@unhandled.com -s $DST_HOST -q mail | grep -A1 MAIL | grep "250 OK (system policy, certificate)"