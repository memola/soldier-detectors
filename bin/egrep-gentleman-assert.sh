#!/bin/bash
thisdir=`dirname $0`
SINGULAR=""
PLURAL=""
old_IFS=$IFS         
IFS=$'\n'
for line in `grep -v "^#" $thisdir/person-types.lst`; do
	s=`echo $line | cut -f 1 -d$'\t'`
	p=`echo $line | cut -f 2 -d$'\t'`
	SINGULAR+="|$s"
	PLURAL+="|$p"
done
IFS=$old_IFS 
SINGULAR=`echo $SINGULAR | sed "s/^\|//"`
PLURAL=`echo $PLURAL | sed "s/^\|//"`
. $thisdir/egrep-assert-present.cmds
. $thisdir/egrep-assert-past.cmds
