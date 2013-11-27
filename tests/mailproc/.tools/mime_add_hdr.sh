#!/bin/bash -ex

sender=$1
recipients=$2
realms=$3
[ -n "$sender" ]
[ -n "$recipients" ]
[ -n "$realms" ]
for r in $recipients; do recipient=$r; break; done
shift
shift
shift
for m in "$@"; do
	rm -fv $m.new
	echo -ne "X-AdvancedFiltering-Sender: $sender\r\n" >> $m.new
	echo -ne "X-AdvancedFiltering-Recipient: $recipient\r\n" >> $m.new
	echo -ne "X-AdvancedFiltering-Recipients: $recipients\r\n" >> $m.new
	echo -ne "X-AdvancedFiltering-Realms: $realms\r\n" >> $m.new
	cat $m >> $m.new
	mv -vf $m.new $m
done
