#!/bin/sh -ex
mkdir .tmp
cd .tmp
tar -xvf ../../../deploy/tasks/315_smtp_exim/smtp.tgz
cp -vf ../exim/configure advancedfiltering/smtp/exim/
cp -vf ../exim/advancedfiltering_smtp_exim etc/rc.d/
chmod a-w etc/rc.d/advancedfiltering_smtp_exim advancedfiltering/smtp/exim/configure
tar -zcvf ../../../deploy/tasks/315_smtp_exim/smtp.tgz etc/rc.d/* advancedfiltering/smtp/.??* advancedfiltering/smtp/*
cd ..
rm -Rvf .tmp
