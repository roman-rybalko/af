#!/bin/sh -ex
mkdir .1
cd .1
tar -xvf ../../../deploy/tasks/460_ldaprepl/ldaprepl.tgz
rm -vf bin/*
cp -avfL ../* bin/
tar -zcvf ../../../deploy/tasks/460_ldaprepl/ldaprepl.tgz *
cd ..
rm -Rvf .1
