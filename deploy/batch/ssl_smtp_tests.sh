#!/bin/sh -ex

cd ..

rm -vf hosts_batch/*.ok
rm -vf tasks_batch/*
ln -sv ../tasks/030_system_ssl ../tasks/030_user_ssl_del ../tasks/031_user_ssl_ca ../tasks/032_user_ssl_smtp tasks_batch/
./deploy.sh tasks_batch hosts_batch
for f in hosts_batch/*.fail; do [ ! -e $f ]; done
echo OK
