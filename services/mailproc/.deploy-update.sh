#!/bin/sh -ex
mkdir .1
cd .1
tar -xvf ../../../deploy/tasks/360_mailproc/mailproc.tgz
rm -vf bin/*
cp -avfL ../* bin/
tar -zcvf ../../../deploy/tasks/360_mailproc/mailproc.tgz *
cd ..
rm -Rvf .1
