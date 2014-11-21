#!/bin/sh -ex
. ./framework.sh
DEPLOY_BATCH_REORDER="565_submission_exim_test_del 10_submission_exim_test_del 550_submission_exim_del 20_submission_exim_del 558_submission_ssl_del 30_submission_ssl_del"
deploy_batch
