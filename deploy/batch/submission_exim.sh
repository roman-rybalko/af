#!/bin/sh -ex
. ./framework.sh
deploy_batch 550_submission_exim_del 560_submission_exim 559_submission_ssl

# tests
deploy_batch 565_submission_exim_test_del 570_submission_exim_test
