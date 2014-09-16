#!/bin/sh -ex

. "$TESTCONF"

swaks -tls -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID message-received-1
swaks -tls --tls-cert tests-bwlist.crt --tls-key tests-bwlist.key -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID message-received-2
wait_file server.mime
grep ^Received server.mime | grep ' from '
grep ^Received server.mime | grep ' with esmtps '
grep ^Received server.mime | grep ' by '
grep ^Received server.mime | grep ' with esmtps ('
grep ^Received server.mime | grep ') (/O=advancedfiltering/OU=hosts/CN=tests-bwlist)'
grep ^Received server.mime | grep -v ') (/O=advancedfiltering/OU=hosts/CN=tests-bwlist)'
grep '^ id ' server.mime | grep ' (envelope-from <test@tests.advancedfiltering.net>) for mbox@test.com; '
