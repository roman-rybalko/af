#!/bin/sh -ex
. ./framework.sh
deploy_batch 030_system_ssl 035_user_ssl_del 036_user_ssl 037_user_ssl_ca 038_user_ssl_smtp
