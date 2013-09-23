#!/bin/sh -ex
. ./common.sh
cd ..
DEPLOY_BATCH_REORDER="250_nginx_del 010_nginx_del 300_exim_del 020_exim_del 350_mailproc_del 040_mailproc_del 200_ldap_del 050_ldap_del"
deploy_batch 210_ldap 230_ldap_services_add 310_exim 330_exim_st_mp_e_b 260_nginx 270_nginx_d_st 360_mailproc
#deploy_batch 370_mailproc_tests
#deploy_batch 220_ldap_tests_add 220_ldap_root_add
deploy_batch 371_mailproc_tests_vfds
echo OK
