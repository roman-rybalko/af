#!/bin/sh -ex
mkdir .tmp
cd .tmp
tar -xvf ../../../deploy/tasks/560_submission_exim/submission.tgz

rm -vf etc/rc.d/*
cp -vf ../exim/advancedfiltering_submission_exim etc/rc.d/

chmod -Rv u+w advancedfiltering/submission/exim
cp -vf ../exim/configure advancedfiltering/submission/exim/
cp -vf ../../smtp/exim/mid_list_encoder.pl advancedfiltering/submission/exim/
cp -vf ../exim/dmarc_verifier.pl ../exim/dmarc_verifier_*.dat advancedfiltering/submission/exim/
chmod a-w etc/rc.d/advancedfiltering_submission_exim advancedfiltering/submission/exim/configure \
	advancedfiltering/submission/exim/mid_list_encoder.pl \
	advancedfiltering/submission/exim/dmarc_verifier.pl \
	advancedfiltering/submission/exim/dmarc_verifier_*.dat \
	advancedfiltering/submission/exim

chmod -Rv u+w advancedfiltering/submission/mbxchk/logread
rm -Rvf advancedfiltering/submission/mbxchk/logread/*
cp -Rvf ../../logread/* advancedfiltering/submission/mbxchk/logread/
cp -Rvf ../mbxchk/logread/* advancedfiltering/submission/mbxchk/logread/
chmod -Rv a-w advancedfiltering/submission/mbxchk/logread

chmod -Rv u+w advancedfiltering/submission/mbxchk/logexec
rm -Rvf advancedfiltering/submission/mbxchk/logexec/*
cp -Rvf ../../logexec/* advancedfiltering/submission/mbxchk/logexec/
cp -Rvf ../mbxchk/logexec/* advancedfiltering/submission/mbxchk/logexec/
chmod -Rv a-w advancedfiltering/submission/mbxchk/logexec

tar -zcvf ../../../deploy/tasks/560_submission_exim/submission.tgz etc/rc.d/* advancedfiltering/submission/.??* advancedfiltering/submission/*

cd ..
chmod -Rv u+w .tmp
rm -Rvf .tmp
