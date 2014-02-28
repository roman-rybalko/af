#!/bin/sh -ex
. ./remote.conf
crontab -l
crontab -l | grep -v /usr/libexec/hprop > crontab.new
h=`hostname`
for s in `./getkrbserver.sh $REALM`; do
	if ./getkrbmaster.sh $REALM | grep $s; then
		# skip hprop into master
		continue
	fi
	/usr/libexec/hprop $s
	echo "*/15 * * * * /usr/libexec/hprop $s" >> crontab.new
done
crontab crontab.new
crontab -l
