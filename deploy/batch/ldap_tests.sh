#!/bin/sh -ex

cd ..

rm -vf hosts_batch/*.ok
rm -vf tasks_batch/*
ln -sv ../tasks/200_ldap_del ../tasks/210_ldap ../tasks/220_ldap_tests_add ../tasks/220_ldap_root_add ../tasks/230_ldap_services_add tasks_batch/
./deploy.sh tasks_batch hosts_batch
for f in hosts_batch/*.fail; do [ ! -e $f ]; done
echo OK
