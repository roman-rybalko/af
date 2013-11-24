#!/bin/sh -ex
mkdir .1
cd .1
tar -xvf ../../../deploy/tasks/510_mbxchk/mbxchk.tgz
rm -vf bin/*
cp -avf ../* bin/
tar -zcvf ../../../deploy/tasks/510_mbxchk/mbxchk.tgz *
cd ..
rm -Rvf .1
