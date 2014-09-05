#!/bin/sh -ex
. ./framework.sh
DEPLOY_BATCH_REORDER="000_sample 001_sample"
deploy_batch 010_another_sample
