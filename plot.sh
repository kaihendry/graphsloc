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
set term svg size 1024,768
set title "$1 https://github.com/kaihendry/graphsloc"
set xdata time
set xtics rotate by 45 right
set timefmt "%s"
set format y '%.0s %c'
set ylabel "Source lines of code"
unset key
set tic scale 0
set grid ytics
plot \$data u 1:2 w lines
END
