#!/bin/sh -ex

. $TESTCONF

swaks -f test@advancedfiltering.net -t mail@unhandled.com -s $DST_HOST -q rcpt | grep "The domain is not in service"
swaks -f test@advancedfiltering.net -t mail@test-r2.com -s $DST_HOST -q rcpt | grep "Moved, try another host"
swaks -f test@advancedfiltering.net -t absent@test.com -s $DST_HOST -q rcpt | grep "Mail box does not exist"
swaks -f test@advancedfiltering.net -t absent@test-alias.com -s $DST_HOST -q rcpt | grep "Mail box does not exist"
swaks -f test@advancedfiltering.net -t unknown@test.com -s $DST_HOST -q rcpt | grep "Your data is verifying, try again later"
swaks -f test@advancedfiltering.net -t existing@test.com -s $DST_HOST -q rcpt | grep QUIT
swaks -f test@advancedfiltering.net -t existing@test-alias.com -s $DST_HOST -q rcpt | grep QUIT
