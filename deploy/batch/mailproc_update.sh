#!/bin/sh -ex
. ./common.sh
cd ..
DEPLOY_BATCH_REORDER=
deploy_batch 360_mailproc_update
echo OK
