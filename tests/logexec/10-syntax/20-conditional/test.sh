#!/bin/sh -ex
. "$TESTCONF"

"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/Test<>?AdvancedFiltering/Test<>:AdvancedFiltering/Test<>'
"$TESTDIR"/.target/logexec-cli.sh ' AdvancedFiltering/Test<1> ? AdvancedFiltering/Test<1> : AdvancedFiltering/Test<> '

if "$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/TestNA<> ? AdvancedFiltering/Test<1> : AdvancedFiltering/Test<>'; then
	false
else
	[ $? = 2 ]
fi
if "$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/Test<> ? AdvancedFiltering/TestNA<> : AdvancedFiltering/Test<>'; then
	false
else
	[ $? = 2 ]
fi

if "$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/Test<> ? AdvancedFiltering/Test<>'; then
	false
else
	[ $? = 2 ]
fi
if "$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/Test<> ? AdvancedFiltering/Test<> : '; then
	false
else
	[ $? = 2 ]
fi
if "$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/Test<> ? AdvancedFiltering/Test : '; then
	false
else
	[ $? = 2 ]
fi
if "$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/Test< ? AdvancedFiltering/Test<> : >'; then
	false
else
	[ $? = 2 ]
fi

if "$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/Test<> ? AdvancedFiltering/Test<1> : AdvancedFiltering/Test<>'; then
	false
else
	[ $? = 1 ]
fi
if "$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/Test<3> ? AdvancedFiltering/Test<> : AdvancedFiltering/Test<2>'; then
	false
else
	[ $? = 1 ]
fi
