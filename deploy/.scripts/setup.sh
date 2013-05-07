#! /bin/sh

set -e
set -x

srv=$1
dir=$2
[ -n "$srv" ]
[ -n "$dir" ]

control_srv="control.srv.kdl-test.ru"
working_dir=`pwd`/$dir
script_dir=`dirname $0`
target_working_dir="/mnt/control"
target_pending_subdir="pending"
target_finished_subdir="finished"
target_failed_subdir="failed"
target_bin_dir="/opt/sbin"

mkdir $working_dir
mkdir $working_dir/$target_pending_subdir; chmod a+w $working_dir/$target_pending_subdir
mkdir $working_dir/$target_finished_subdir; chmod a+w $working_dir/$target_finished_subdir
mkdir $working_dir/$target_failed_subdir; chmod a+w $working_dir/$target_failed_subdir

sed_script="s~{BIN_DIR}~$target_bin_dir~g; \
    s~{WORKING_DIR}~$target_working_dir~g; \
    s~{PENDING_DIR}~$target_pending_subdir~g; \
    s~{FINISHED_DIR}~$target_finished_subdir~g; \
    s~{FAILED_DIR}~$target_failed_subdir~g; \
    "

sed -e "$sed_script" $script_dir/cron > $working_dir/control
sed -e "$sed_script" $script_dir/bin.sh > $working_dir/control.sh
chmod a+x $working_dir/control.sh

login_pos=`expr index $srv "@"` || true
target_pos=`expr $login_pos + 1`
target_len=`expr length $srv`
target_len=`expr $target_len - $login_pos`
target=`expr substr $srv $target_pos $target_len`

echo "$working_dir $target(rw,sync,subtree_check)" >> /etc/exports
exportfs -rv

ssh $srv -- "
echo \"$control_srv:$working_dir $target_working_dir nfs bg 0 0\" >> /etc/fstab;
mkdir $target_working_dir;
mount $target_working_dir;
cp $target_working_dir/control /etc/cron.d/;
mkdir -p $target_bin_dir;
cp $target_working_dir/control.sh $target_bin_dir/;
"
echo deployed
