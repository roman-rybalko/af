#!/bin/sh -ex

. ./common.sh
cd ..

deploy_batch 005_hostname  999_reboot

echo OK
