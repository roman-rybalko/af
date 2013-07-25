#!/bin/sh -ex

cd ..

rm -vf hosts_batch/*.ok
rm -vf tasks_batch/*
ln -sv ../tasks/065_geli_attach tasks_batch/
./deploy.sh tasks_batch hosts_batch
for f in hosts_batch/*.fail; do [ ! -e $f ]; done
echo OK
