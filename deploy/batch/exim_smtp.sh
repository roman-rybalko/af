#!/bin/sh -ex
. ./framework.sh
deploy_batch 300_exim_del 301_exim_smtp_del 310_exim 320_exim_smtp
