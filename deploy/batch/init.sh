#!/bin/sh -ex

cd ..

rm -vf hosts_init/*.ok
./deploy.sh tasks_init hosts_init
for f in hosts_init/*.fail; do [ ! -e $f ]; done

rm -vf hosts/*.ok
./deploy.sh tasks_init2 hosts
for f in hosts/*.fail; do [ ! -e $f ]; done

sleep 120

rm -vf hosts/*.ok
./deploy.sh tasks_init3 hosts
for f in hosts/*.fail; do [ ! -e $f ]; done
