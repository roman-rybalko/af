#!/bin/sh -ex
mkdir .tmp
cd .tmp
tar -xvf ../../../deploy/tasks/315_smtp_exim/smtp.tgz
cp -vf ../exim/advancedfiltering_smtp_exim etc/rc.d/
cp -vf ../exim/configure advancedfiltering/smtp/exim/
cp -vf ../exim/message_loop_detector.pl advancedfiltering/smtp/exim/
cp -vf ../exim/mid_list_encoder.pl advancedfiltering/smtp/exim/
cp -vf ../exim/base64_decoder.pl advancedfiltering/smtp/exim/
chmod a-w etc/rc.d/advancedfiltering_smtp_exim advancedfiltering/smtp/exim/configure \
	advancedfiltering/smtp/exim/message_loop_detector.pl \
	advancedfiltering/smtp/exim/mid_list_encoder.pl advancedfiltering/smtp/exim/base64_decoder.pl
tar -zcvf ../../../deploy/tasks/315_smtp_exim/smtp.tgz etc/rc.d/* advancedfiltering/smtp/.??* advancedfiltering/smtp/*
cd ..
rm -Rvf .tmp
