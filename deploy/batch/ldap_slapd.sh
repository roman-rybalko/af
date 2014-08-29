#!/bin/sh -ex
. ./framework.sh
deploy_batch 210_ldap_slapd_del 215_ldap_slapd

# tests
deploy_batch 220_ldap_slapd_tests_add 220_ldap_slapd_root_add
