#!/bin/sh -ex
. ./framework.sh
deploy_batch 200_ldap_del 210_ldap 220_ldap_tests_add 220_ldap_root_add
