#!/bin/sh

set -ex
H=h01.hosts.advancedfiltering.net

swaks -f test@advancedfiltering.net -t mail@unhandled.com -s $H -q rcpt | grep "The domain is not in service"
swaks -f test@advancedfiltering.net -t mail@test-r2.com -s $H -q rcpt | grep "Moved, try another host"
swaks -f test@advancedfiltering.net -t absent@test.com -s $H -q rcpt | grep "Mail box does not exist"
swaks -f test@advancedfiltering.net -t absent@test-alias.com -s $H -q rcpt | grep "Mail box does not exist"
swaks -f test@advancedfiltering.net -t unknown@test.com -s $H -q rcpt | grep "Your data is verifying, try again later"
swaks -f test@advancedfiltering.net -t existing@test.com -s $H -q rcpt | grep QUIT
swaks -f test@advancedfiltering.net -t existing@test-alias.com -s $H -q rcpt | grep QUIT

echo OK
