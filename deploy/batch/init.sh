#!/bin/sh -ex
. ./framework.sh

for p in hosts_batch/*.pw; do [ -e $p ]; done
deploy_batch 008_resolv_search 009_pkg_repo 010_kerberos 020_deploy

for p in hosts_batch/*.pw; do rm -vf $p; done
deploy_batch 035_system_ssl  050_env  051_security_root_ssh  999_reboot

deploy_batch 052_local_af_init
