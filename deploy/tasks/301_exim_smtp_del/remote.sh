#!/bin/sh -ex
. ./remote.conf

./db-mod.sh -c || true
