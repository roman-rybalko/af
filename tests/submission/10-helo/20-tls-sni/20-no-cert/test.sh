#!/bin/sh -ex

. "$TESTCONF"

swaks -tls --tls-cert client.crt --tls-key client.key --tls-sni submission.submission-test.clients.advancedfiltering.net -f test@test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q helo | ! grep Hallo
swaks -tls --tls-cert client.crt --tls-key client.key --tls-sni submission.submission-test.clients.advancedfiltering.net -f test@test.advancedfiltering.net -t mbox@test.com -s $DST_HOST -p submission -q helo | grep CN=submission.services
