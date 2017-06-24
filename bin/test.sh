#!/bin/bash

bindir=`dirname $0`

testdir="$bindir/test"

tmpdir="$testdir/tmp"

cases=("egrep-soldier-assert-present")

for case in $cases; do
	casedir="$testdir/$case"
	mkdir -p $tmpdir/$case
	rm -r $tmpdir/$case/*
	ctr=0
	while IFS='$\n' read -r line; do
		ctr=$(($ctr+1))
		fname=`printf %03d $ctr`
		mkdir -p $tmpdir/$case/$fname
		echo $line > $tmpdir/$case/$fname/yes.txt
	done < <(grep -v -e '^#' $casedir/include/matches.txt | grep -v -e '^$')
	ctr=$(($ctr+1))
	fname=`printf %03d $ctr`
	mkdir -p $tmpdir/$case/$fname
	grep -v -e '^#' $casedir/include/multiline.txt | grep -v -e '^$' > $tmpdir/$case/$fname/yes.txt

	while IFS='$\n' read -r line; do
		ctr=$(($ctr+1))
		fname=`printf %03d $ctr`
		mkdir -p $tmpdir/$case/$fname
		echo $line > $tmpdir/$case/$fname/no.txt
	done < <(grep -v -e '^#' $casedir/exclude/matches.txt | grep -v -e '^$')

	for check in `ls $tmpdir/$case`; do
		len=`$bindir/$case.sh $tmpdir/$case/$check | wc -l`
		if [ -e "$tmpdir/$case/$check/yes.txt" ]; then
			if [ $len = 0 ]; then
				echo "$case $check failed to match \"$(cat $tmpdir/$case/$check/yes.txt)\""
			fi
		else
			if [ $len != 0 ]; then
				echo "$case $check failed to exclude \"$(cat $tmpdir/$case/$check/no.txt)\""
			fi
		fi
	done
done
