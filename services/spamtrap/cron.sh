#!/bin/sh -ex

. `dirname $0`/spamtrap.conf

`dirname $0`/clean.sh
`dirname $0`/update.sh
`dirname $0`/export-db.sh
