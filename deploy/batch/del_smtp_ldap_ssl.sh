#!/bin/sh -ex
. ./framework.sh
DEPLOY_BATCH_REORDER="320_smtp_exim_tests_del 10_smtp_exim_tests_del 310_smtp_exim_del 20_smtp_exim_del 210_ldap_slapd_del 40_ldap_slapd_del 030_ssl_del 60_ssl_del"
deploy_batch
