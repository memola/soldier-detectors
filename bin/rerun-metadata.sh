#!/bin/bash
bindir=`dirname $0`
tmpdir=$bindir/tmp
mkdir $tmpdir
DIR=`dirname $1`
if [ $DIR = '.' ]; then
	DIR=$1
	prefix=""
else
	prefix=`echo $DIR | sed -e $'s|/|__|g'`
	prefix="${prefix}_"
fi

echo "${prefix}soldier.csv"
python $bindir/join.py $1 $tmpdir/simple-soldier-states.txt "${prefix}soldier.csv"