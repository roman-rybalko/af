#! /bin/sh

set -e
#set -x

working_dir="{WORKING_DIR}"
pending_dir="{PENDING_DIR}"
finished_dir="{FINISHED_DIR}"
failed_dir="{FAILED_DIR}"
lock_file="/var/lock/control.lock"

cd $working_dir

[ \! -e "$lock_file" ] || exit 0
touch "$lock_file"

for task_file in "$pending_dir"/*; do
    [ -e "$task_file" ] || continue
    if [ -f "$task_file" -a -x "$task_file" ]; then
        "$task_file" && mv -f "$task_file" "$finished_dir" || mv -f "$task_file" "$failed_dir"
    else
        echo "Strange taskfile: $task_file"
        mv -f "$task_file" "$failed_dir"
    fi
done

rm -f "$lock_file"
