#!/bin/sh -ex

. `dirname $0`/spamtrap.conf

export HOME
find $SPAM -type f -mtime +42 -print0 | xargs -0 rm -fv
find $HAM -type f -mtime +42 -print0 | xargs -0 rm -fv
find $EXPORT -type f -mtime +7 -print0 | xargs -0 rm -fv
