# Graph SLOC

Update: Rewritten in Go https://github.com/kaihendry/lesshero

Usage example:

	$ ./collect-stats.sh ~/suckless/dwm
	1645 git commits
	Progress : [########################################] 100%
	./plot.sh dwm-3465bed.csv | gnuplot > dwm-3465bed.csv.svg
	$ ./plot.sh dwm-3465bed.csv | gnuplot > dwm-3465bed.csv.svg
	$ google-chrome-unstable dwm-3465bed.csv.svg

## Using a "proper" SLOC counter

<img src=http://s.natalian.org/2016-03-03/sloc-dwm-3465bed.svg alt="sloc of dwm">

Using a proper [SLOC counter](https://github.com/flosse/sloc) is slow!

## Using `git show --numstat`

<img src=http://s.natalian.org/2016-03-12/dwm-3465bed.csv.svg alt="lines of dwm">

## Conclusion

The trend (shape of the graph) is the same so I don't think it's worth counting
or debating what is a
[SLOC](https://en.wikipedia.org/wiki/Source_lines_of_code).

SUCK LESS! Remember going down is better than up! Flat means stable.
