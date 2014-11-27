#!/bin/sh -ex

. "$TESTCONF"

swaks -tls --tls-cert client.crt --tls-key client.key --tls-sni submission.submission-test.clients.advancedfiltering.net -f test@test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q helo | grep Hallo | grep 'submission-test TLS SNI'
swaks -tls --tls-cert client.crt --tls-key client.key --tls-sni submission1.submission-test.clients.advancedfiltering.net -f test@test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q helo | grep Hallo | grep 'submission-test TLS SNI'
swaks -tls --tls-cert client.crt --tls-key client.key --tls-sni submission2.submission-test.clients.advancedfiltering.net -f test@test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q helo | grep Hallo | grep 'submission-test TLS SNI'
swaks -tls --tls-cert client.crt --tls-key client.key --tls-sni submission22.submission-test.clients.advancedfiltering.net -f test@test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q helo | grep Hallo | grep 'submission-test TLS SNI'

swaks -tls --tls-cert client.crt --tls-key client.key --tls-sni submission.submission-test.clients.advancedfiltering.net -f test@test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q helo | grep O=advancedfiltering | grep OU=tests | grep CN=submission

swaks -tls --tls-sni submission.submission-test.clients.advancedfiltering.net -f test@test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q helo | ! grep Hallo
