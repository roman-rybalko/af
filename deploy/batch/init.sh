#!/bin/sh -ex

. ./common.sh
cd ..

for p in hosts_batch/*.pw; do [ -e $p ]; done
deploy_batch 009_resolv_search 010_kerberos 020_deploy

for p in hosts_batch/*.pw; do mv -v hosts_batch/$p hosts_batch/.$p; done
deploy_batch 030_system_ssl  050_env  051_security_root_ssh  999_reboot

deploy_batch 052_local_af_init
#sleep 120
#deploy_batch 060_geli_init  065_geli_attach

echo OK
