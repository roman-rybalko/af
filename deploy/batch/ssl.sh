#!/bin/sh -ex
. ./framework.sh
deploy_batch 030_ssl_del 035_system_ssl 036_user_ssl 037_user_ssl_ca
