#!/bin/bash

if ! test -s "$1" || test "${1##*.}" != "csv"
then
	echo Usage: "$0" foo.csv
	exit
fi

echo \$data \<\<EOD
cat "$1"
echo EOD

cat << END
set term svg size 800,600 fname "Helvetica Neue" fsize 9 rounded dashed
set title "$1"
set xdata time
set timefmt "%s"
plot \$data u 1:2 w lines
END
