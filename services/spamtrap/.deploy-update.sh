#!/bin/sh -ex
mkdir .1
cd .1
tar -xvf ../../../deploy/tasks/410_spamtrap/spamtrap.tgz
rm -vf bin/*
cp -avf ../* bin/
tar -zcvf ../../../deploy/tasks/410_spamtrap/spamtrap.tgz *
cd ..
rm -Rvf .1
