
timed_wait()
{
	pid=$1
	timeout=$2
	count=100
	timestep=`expr $timeout / $count`
	while [ $count -gt 0 ]; do
		kill -0 $pid || return 0
		usleep $timestep
		count=$(($count-1))
	done
	return 1
}

run_target()
{
	"$TESTDIR"/.target/logread.sh "$@" &
	pid=$!
	if timed_wait $pid 500000; then
		true
	else
		kill $pid
		false
	fi
}
