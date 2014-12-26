#!/bin/sh -ex

. "$TESTCONF"

swaks -f test@tests.advancedfiltering.net -t mbox2@test2.com -s $DST_HOST -h-Message-ID test-message-id-2 -h-References test-outgoing-message-2 | grep -E "2[[:digit:]][[:digit:]].MO/HT \\(Reply\\) id="
swaks -f test@tests.advancedfiltering.net -t mbox2@test2.com -s $DST_HOST -h-Message-ID test-message-id-2 -h-References '   <test-outgoing-message-2>    <test2>' | grep -E "2[[:digit:]][[:digit:]].MO/HT \\(Reply\\) id="
swaks -f test@tests.advancedfiltering.net -t mbox2@test2.com -s $DST_HOST -h-Message-ID test-message-id-2 -h-References ' <test4>, <test-outgoing-message-2>, <test2>' | grep -E "2[[:digit:]][[:digit:]].MO/HT \\(Reply\\) id="
swaks -f test@tests.advancedfiltering.net -t mbox2@test2.com -s $DST_HOST -h-Message-ID test-message-id-2 -h-References 'test4    <test-outgoing-message-2> test2' | grep -E "2[[:digit:]][[:digit:]].MO/HT \\(Reply\\) id="
swaks -f test@tests.advancedfiltering.net -t mbox2@test2.com -s $DST_HOST -h-Message-ID test-message-id-2 -h-References 'test4>, <test-outgoing-message-2>, <test2' | grep -E "2[[:digit:]][[:digit:]].MO/HT \\(Reply\\) id="
