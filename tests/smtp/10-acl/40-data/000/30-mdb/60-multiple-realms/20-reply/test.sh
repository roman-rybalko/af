#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox2@test.com,mbox2@test2.com,mbox2@test3.com -s $DST_HOST -h-Message-ID test-message-id-1 -h-In-Reply-To test-outgoing-message-1
wait_file server.env
