#!/bin/sh -ex

cd ..

rm -vf hosts_batch/*.ok
rm -vf tasks_batch/*
ln -sv ../tasks/300_exim_del tasks_batch/020_exim_del
ln -sv ../tasks/250_nginx_del tasks_batch/010_nginx_del
ln -sv ../tasks/400_spamtrap_del tasks_batch/030_spamtrap_del
ln -sv ../tasks/350_mailproc_del tasks_batch/040_mailproc_del
ln -sv ../tasks/200_ldap_del tasks_batch/050_ldap_del
ln -sv ../tasks/210_ldap ../tasks/220_ldap_tests_add ../tasks/220_ldap_root_add \
 ../tasks/310_exim ../tasks/330_exim_st_mp_e_b \
 ../tasks/260_nginx ../tasks/270_nginx_d_st \
 ../tasks/360_mailproc ../tasks/370_mailproc_tests \
 tasks_batch/
./deploy.sh tasks_batch hosts_batch
for f in hosts_batch/*.fail; do [ ! -e $f ]; done
echo OK
