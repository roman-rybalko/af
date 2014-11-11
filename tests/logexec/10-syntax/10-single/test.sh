#!/bin/sh -ex
. "$TESTCONF"

"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/Test<>'
"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/Test<><1>'
"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/Test<0>'
"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/Test<0><><><><><1><2>'
"$TESTDIR"/.target/logexec-cli.sh '   AdvancedFiltering/Test<>'
"$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/Test<>   '
"$TESTDIR"/.target/logexec-cli.sh '     AdvancedFiltering/Test<>       '

if "$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/TestNA<>'; then
	false
else
	[ $? = 2 ]
fi

if "$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/Test<'; then
	false
else
	[ $? = 2 ]
fi

if "$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/Test'; then
	false
else
	[ $? = 2 ]
fi

if "$TESTDIR"/.target/logexec-cli.sh 'AdvancedFiltering/Test<1>'; then
	false
else
	[ $? = 1 ]
fi
