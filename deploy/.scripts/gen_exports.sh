#! /bin/sh

for d in *; do
    [ -d $d ] && echo "/opt/share/control/$d	$d.srv.kdl-test.ru(rw,sync,subtree_check)"
done
