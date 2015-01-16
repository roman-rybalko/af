#!/bin/sh -ex

. "$TESTCONF"

swaks -tls -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID message-received-1
swaks -tls --tls-cert tests-bwlist.crt --tls-key tests-bwlist.key -f test@tests.advancedfiltering.net -t mbox@test.com -s $DST_HOST --h-Message-ID message-received-2
wait_file mx.mime
grep ^Received mx.mime | grep ' from '
grep ^Received mx.mime | grep ' with esmtps '
grep ^Received mx.mime | grep ' by '
grep ^X-Envelope-From mx.mime | grep test@tests.advancedfiltering.net
grep ^X-Envelope-To mx.mime | grep mbox@test.com
