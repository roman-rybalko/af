#!/bin/sh -ex

. "$TESTCONF"

swaks -tls -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID message-received-1
swaks -tls --tls-cert tests-bwlist.crt --tls-key tests-bwlist.key -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID message-received-2
wait_file mx.mime
grep ^Received mx.mime | grep ' from '
grep ^Received mx.mime | grep ' with esmtps '
grep ^Received mx.mime | grep ' by '
grep ^Received mx.mime | grep ' with esmtps ('
grep ^Received mx.mime | grep ') (/O=advancedfiltering/OU=hosts/CN=tests-bwlist)'
grep ^Received mx.mime | grep -v ') (/O=advancedfiltering/OU=hosts/CN=tests-bwlist)'
grep '^ id ' mx.mime | grep ' (envelope-from <test@tests.advancedfiltering.net>) for mbox@test.com; '
