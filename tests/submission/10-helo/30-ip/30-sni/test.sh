#!/bin/sh -ex

. "$TESTCONF"

swaks -tls --tls-cert client.crt --tls-key client.key --tls-sni submission.submission-test.clients.advancedfiltering.net -f test@test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q helo | grep Hallo | head -n 1 | grep 'cli1 IP'
swaks -tls --tls-cert client.crt --tls-key client.key --tls-sni submission.submission-test.clients.advancedfiltering.net -f test@test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q helo | grep Hallo | tail -n 1 | grep 'submission-test TLS SNI'
