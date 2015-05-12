
common_init()
{
	usleep 1
}

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
	"$TESTDIR"/.target/logread.sh -i logread-test -f local0 "$@" &
	pid=$!
	if timed_wait $pid 500000; then
		true
	else
		kill $pid
		false
	fi
}

start_target()
{
	rm -f logread.pid
	"$TESTDIR"/.target/logread.sh -i logread-test -f local0 "$@" &
	echo $! > logread.pid
}

stop_target()
{
	kill `cat logread.pid` || true
	rm -f logread.pid
}

wait_file()
{
	local c f
	f=$1
	c=50
	while [ $c -gt 0 ]; do
		[ ! -e $f ] || return 0
		c=$(($c-1))
		usleep 100000
	done
	return 1
}

wait_line()
{
	local c f r
	f=$1
	r="$2"
	c=50
	while [ $c -gt 0 ]; do
		! grep "$r" $f || return 0
		c=$(($c-1))
		usleep 100000
	done
	return 1
}
