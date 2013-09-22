#!/bin/sh -ex

. ./common.sh
cd ..

DEPLOY_BATCH_REORDER="400_spamtrap_del 010_spamtrap_del 250_nginx_del 020_nginx_del 300_exim_del 030_exim_del"
deploy_batch 310_exim 330_exim_st_mp_e_b 260_nginx 270_nginx_d_st 410_spamtrap 415_spamtrap_samples 420_spamtrap_db_update

echo OK
