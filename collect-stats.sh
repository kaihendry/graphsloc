#!/bin/bash

if test -z "$1" || ! test -d "$1/.git"
then
	echo Usage "$0" /path/to/git/repo
	exit
fi

findwc() {
	find -type f -not -path '*/\.*' -exec wc -l {} + | tail -n1 | awk '{ print $1 }'
}

sloc() {
	sloc -f json . | jq .summary.total
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

for (( i=0; i < $len; i+=$inc ));
do
	git checkout -q "${revs[$i]}"
	echo "$(git show -s --format="%ct" .)" "$(findwc)" >> "$fn"
	echo $i / $len $((200*$i/$len % 2 + 100*$i/$len))\%
done

# Reset
git checkout master
echo ./plot.sh "$fn" \| gnuplot \> "$fn.svg"
cd "$DIR"
