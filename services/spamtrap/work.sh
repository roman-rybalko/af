#!/bin/sh -ex

. `dirname $0`/spamtrap.conf

while true
do
	`dirname $0`/learn.sh
	`dirname $0`/export-sa.sh
done
