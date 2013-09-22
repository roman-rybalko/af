#!/bin/sh -ex
. ./common.sh
cd ..
DEPLOY_BATCH_REORDER="000_sample 001_sample"
deploy_batch 000_sample
echo OK
