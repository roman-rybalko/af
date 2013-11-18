#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST -h-Message-ID test-message-id-2 -h-References test-outgoing-message-2
swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST -h-Message-ID test-message-id-2 -h-References '   <test-outgoing-message-2>    <test2>'
swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST -h-Message-ID test-message-id-2 -h-References ' <test4>, <test-outgoing-message-2>, <test2>'
swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST -h-Message-ID test-message-id-2 -h-References 'test4    <test-outgoing-message-2> test2'
swaks -f test@tests.advancedfiltering.net -t mbox2@test.com -s $DST_HOST -h-Message-ID test-message-id-2 -h-References 'test4>, <test-outgoing-message-2>, <test2'
wait_file server.env
