#!/bin/sh -ex

. "$TESTCONF"

swaks -tls --tls-cert tests.crt --tls-key tests.key -f mbox@test.advancedfiltering.net -t test@dmarc.test.advancedfiltering.net -s $DST_HOST -p submission --h-In-Reply-To test-message-id-1 --h-Message-Id test-message-id-2
wait_file ht.env
grep hamtrap ht.env
wait_ldif_add user2.ldif
