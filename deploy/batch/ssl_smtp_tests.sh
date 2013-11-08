#!/bin/sh -ex
. ./framework.sh
deploy_batch 030_system_ssl 030_user_ssl_del 031_user_ssl_ca 032_user_ssl_smtp
