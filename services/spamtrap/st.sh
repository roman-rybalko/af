#!/bin/sh -ex

while true
do
	`dirname $0`/learn.sh
	`dirname $0`/export-st.sh
done
