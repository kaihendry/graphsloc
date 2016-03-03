#!/bin/bash

test -s "$1" || exit

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
