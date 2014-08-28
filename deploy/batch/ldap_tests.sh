#!/bin/sh -ex
. ./framework.sh
deploy_batch 200_ldap_slapd_del 210_ldap_slapd 220_ldap_slapd_tests_add 220_ldap_slapd_root_add
