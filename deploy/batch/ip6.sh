#!/bin/sh -ex

. ./common.sh
cd ..

deploy_batch 070_ip6 071_ip6_disable_linklocal 999_reboot

echo OK
