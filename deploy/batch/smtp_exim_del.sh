#!/bin/sh -ex
. ./framework.sh
DEPLOY_BATCH_REORDER="320_smtp_exim_test_del 10_smtp_exim_test_del 310_smtp_exim_del 20_smtp_exim_del 308_smtp_ssl_del 30_smtp_ssl_del"
deploy_batch
