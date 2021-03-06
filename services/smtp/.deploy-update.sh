#!/bin/sh -ex
mkdir .tmp
cd .tmp

tar -xvf ../../../deploy/tasks/315_smtp_exim/smtp.tgz

rm -vf etc/rc.d/*
cp -vf ../advancedfiltering_smtp_exim etc/rc.d/

chmod -Rv u+w advancedfiltering/smtp/exim
rm -vf advancedfiltering/smtp/exim/*.conf
cp -vfL ../exim/*.conf advancedfiltering/smtp/exim/
cp -vfL ../../exim/scripts/message_loop_detector.pl \
	../../exim/scripts/mid_list_encoder.pl ../../exim/scripts/base64_decoder.pl \
	../../exim/scripts/dmarc_verifier.pl ../../exim/scripts/dmarc_verifier_*.dat \
	advancedfiltering/smtp/exim/
chmod a-w etc/rc.d/advancedfiltering_smtp_exim advancedfiltering/smtp/exim/*.conf \
	advancedfiltering/smtp/exim/message_loop_detector.pl \
	advancedfiltering/smtp/exim/mid_list_encoder.pl advancedfiltering/smtp/exim/base64_decoder.pl \
	advancedfiltering/smtp/exim/dmarc_verifier.pl advancedfiltering/smtp/exim/dmarc_verifier_*.dat \
	advancedfiltering/smtp/exim

chmod -Rv u+w advancedfiltering/smtp/mbxchk/logread
rm -Rvf advancedfiltering/smtp/mbxchk/logread/*
cp -RvfL ../../logread/* advancedfiltering/smtp/mbxchk/logread/
cp -RvfL ../mbxchk/logread/* advancedfiltering/smtp/mbxchk/logread/
chmod -Rv a-w advancedfiltering/smtp/mbxchk/logread

chmod -Rv u+w advancedfiltering/smtp/mbxchk/logexec
rm -Rvf advancedfiltering/smtp/mbxchk/logexec/*
cp -RvfL ../../logexec/* advancedfiltering/smtp/mbxchk/logexec/
cp -RvfL ../mbxchk/logexec/* advancedfiltering/smtp/mbxchk/logexec/
chmod -Rv a-w advancedfiltering/smtp/mbxchk/logexec

tar -zcvf ../../../deploy/tasks/315_smtp_exim/smtp.tgz etc/rc.d/* advancedfiltering/smtp/.??* advancedfiltering/smtp/*

cd ..
chmod -Rv u+w .tmp
rm -Rvf .tmp
