#!/bin/bash

findwc() {
	find -type f -not -path '*/\.*' -exec wc -l {} + | tail -n1 | awk '{ print $1 }'
}

sloc() {
	sloc -f json . | jq .summary.total
}

test -d "$1/.git" || exit
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$1" || exit

fn=$DIR/$(basename "$(pwd)")-$(git describe --always).csv
git checkout master

test -s "$fn" && exit
git pull
for i in $(git rev-list master)
do
	git checkout -q "$i"
	echo "$(git show -s --format="%ct" .)" "$(findwc)" >> "$fn"
done

# Reset
git checkout master
echo ./plot.sh "$fn" \| gnuplot \> $fn.svg
cd "$DIR"
