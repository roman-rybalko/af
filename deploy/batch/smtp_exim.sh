#!/bin/sh -ex
. ./framework.sh
deploy_batch 310_smtp_exim_del 315_smtp_exim 309_smtp_ssl

# tests
deploy_batch 320_smtp_exim_test_del 325_smtp_exim_test
