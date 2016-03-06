#!/bin/bash

if test -z "$1" || ! test -d "$1/.git"
then
	echo Usage "$0" /path/to/git/repo
	exit
fi

gitrepo=$1

# https://github.com/fearside/ProgressBar/blob/master/progressbar.sh
ProgressBar() {
_progress=$((($1*100/$2*100)/100))
_done=$((_progress*4/10))
_left=$((40-_done))
# Build progressbar string lengths
_done=$(printf "%${_done}s")
_left=$(printf "%${_left}s")
printf "\rProgress : [${_done// /#}${_left// /-}] ${_progress}%%"
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$gitrepo" || exit

fn=$DIR/$(basename "$(pwd)")-$(git describe --always).csv
test -s "$fn" && exit

mapfile -t revs < <(git rev-list master)
len=${#revs[@]}
echo $len git commits
total=0

for (( i=$len; i > 0; i-- ));
do

	#echo git show --numstat --format="%ct" ${revs[$i]}
	#foo=$(git show --numstat --format="%ct" ${revs[$i]} |awk 'NR==1{print;next} NF==3 {plus+=$1; minus+=$2} END {printf(plus-minus)}')
	#set -- $foo

	set -- $(git show --numstat --format="%ct" ${revs[$i]} |awk 'NR==1{print;next} NF==3 {plus+=$1; minus+=$2} END {printf(plus-minus)}')
	time=$1
	count=$2
	#echo $time $count
	total=$((total + count))
	#echo Total $total
	echo $time $total >> $fn
	#ProgressBar $(($len-$i)) $len
done
cd "$DIR"

echo -e "\n ./plot.sh $fn | gnuplot > $fn.svg"
