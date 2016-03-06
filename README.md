# Graph SLOC

Usage example:

	~$ cd /tmp
	/tmp$ git clone git@github.com:kaihendry/graphsloc.git
	Cloning into 'graphsloc'...
	remote: Counting objects: 5, done.
	remote: Compressing objects: 100% (5/5), done.
	remote: Total 5 (delta 0), reused 5 (delta 0), pack-reused 0
	Receiving objects: 100% (5/5), done.
	Checking connectivity... done.
	/tmp$ git clone git://git.suckless.org/dwm
	Cloning into 'dwm'...
	remote: Counting objects: 6265, done.
	remote: Compressing objects: 100% (2977/2977), done.
	remote: Total 6265 (delta 3603), reused 5903 (delta 3287)
	Receiving objects: 100% (6265/6265), 5.79 MiB | 705.00 KiB/s, done.
	Resolving deltas: 100% (3603/3603), done.
	Checking connectivity... done.
	/tmp$ cd graphsloc/
	/tmp/graphsloc$ ./collect-stats.sh ../dwm/
	Already on 'master'
	Your branch is up-to-date with 'origin/master'.
	Already up-to-date.
	Previous HEAD position was 1076f2b... initial import
	Switched to branch 'master'
	Your branch is up-to-date with 'origin/master'.
	./plot.sh /tmp/graphsloc/dwm-3465bed.csv | gnuplot > /tmp/graphsloc/dwm-3465bed.csv.svg
	/tmp/graphsloc$ ./plot.sh /tmp/graphsloc/dwm-3465bed.csv | gnuplot > /tmp/graphsloc/dwm-3465bed.csv.svg
	/tmp/graphsloc$ google-chrome-unstable /tmp/graphsloc/dwm-3465bed.csv.svg
	Created new window in existing browser session.

## Using a proper SLOC counter

<img src=http://s.natalian.org/2016-03-03/sloc-dwm-3465bed.svg alt="sloc of dwm">

Using a proper [SLOC counter](https://github.com/flosse/sloc) is slow!

## Using wc

<img src=http://s.natalian.org/2016-03-03/findwc-dwm-3465bed.svg alt="lines of dwm">

## Conclusion

The trend is the same so I don't think it's worth counting or debating what is
a [SLOC](https://en.wikipedia.org/wiki/Source_lines_of_code).

SUCK LESS! Remember going down is better than up! Flat means stable.
