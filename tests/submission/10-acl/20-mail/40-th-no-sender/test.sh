#!/bin/sh -ex

. "$TESTCONF"

swaks -tls --tls-cert tests.crt --tls-key tests.key -f '<>' -t nomail@nomail.test.advancedfiltering.net -s $DST_HOST -p submission -q mail | smtp_rj.pl | grep -E '5[[:digit:]][[:digit:]] .+empty Envelope-Sender'
