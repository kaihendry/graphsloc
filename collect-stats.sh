#!/bin/bash

if test -z "$1" || ! test -d "$1/.git"
then
	echo Usage "$0" /path/to/git/repo
	exit
fi

findwc() { # fast (though can you make this faster?)
	find -type f -not -path '*/\.*' -exec wc -l {} + | tail -n1 | awk '{ print $1 }'
}

sloc() { # slow
	# https://github.com/flosse/sloc
	sloc -f json . | jq .summary.total
}

# Author : Teddy Skarin
# https://github.com/fearside/ProgressBar/blob/master/progressbar.sh
function ProgressBar {
# Process data
	let _progress=(${1}*100/${2}*100)/100
	let _done=(${_progress}*4)/10
	let _left=40-$_done
# Build progressbar string lengths
	_done=$(printf "%${_done}s")
	_left=$(printf "%${_left}s")

# 1.2 Build progressbar strings and print the ProgressBar line
# 1.2.1 Output example:
# 1.2.1.1 Progress : [########################################] 100%
printf "\rProgress : [${_done// /#}${_left// /-}] ${_progress}%%"
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$1" || exit

fn=$DIR/$(basename "$(pwd)")-$(git describe --always).csv
git checkout master

test -s "$fn" && exit
git pull

mapfile -t revs < <(git rev-list master)
len=${#revs[@]}
inc=1
test "$SAMPLE" && inc=$(($len / $SAMPLE)) && echo Incrementing by $inc
llen=$(($len - $inc))
echo $len git commits

for (( i=0; i < $len; i+=$inc ));
do
	git checkout -q "${revs[$i]}"
	echo "$(git show -s --format="%ct" .)" "$(findwc)" >> "$fn"
	ProgressBar $i $llen
done
echo -e "\n"

git checkout master # Reset
echo ./plot.sh "$fn" \| gnuplot \> "$fn.svg"
cd "$DIR"
