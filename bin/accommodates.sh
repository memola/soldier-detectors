#!/bin/bash
DIR=`dirname $1`
if [ $DIR = '.' ]; then
	DIR=$1
	prefix=""
else
	prefix=`echo $DIR | sed -e $'s|/|__|g'`
	prefix="${prefix}_"
fi

pcregrep  -C 2 -i "\bacc?[aeiou]mm?od[a-z]+" $1/*  | tr $'\n' '*' | sed -e $'s|*'$DIR'|'$'\\\n'$DIR'|g'  | sed -e $'s|*\\-\\-|'$'\\\n--|g' > simple-soldier-states.txt

bindir=`dirname $0`
python $bindir/join.py $1 "${prefix}accommodate-1700.csv"