#!/bin/bash
DIR=`dirname $1`
if [ $DIR = '.' ]; then
	DIR=$1
	prefix=""
else
	prefix=`echo $DIR | sed -e $'s|/|__|g'`
	prefix="${prefix}_"
fi

bindir=`dirname $0`
mkdir $bindir/tmp
pcregrep  -C 2 -i "\bacc?[aeiou]mm?od[a-z]+" $1/*  | tr $'\n' '*' | sed -e $'s|*'$DIR'|'$'\\\n'$DIR'|g'  | sed -e $'s|*\\-\\-|'$'\\\n--|g' > $bindir/tmp/simple-soldier-states.txt

python $bindir/join.py $1 $tmpdir/simple-soldier-states.txt "${prefix}accommodate-1700.csv"