#!/bin/sh -ex
mkdir .1
cd .1
tar -zxvf ../../../deploy/tasks/360_mailproc/mailproc.tgz
cp -avf ../* bin/
tar -zcvf ../../../deploy/tasks/360_mailproc/mailproc.tgz *
cd ..
rm -Rvf .1
