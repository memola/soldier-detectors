#!/bin/bash
./egrep-soldier-assert-present.sh | tr $'\n' '*' | sed -e $'s/*Reproc/\\\nReproc/g' | sort | uniq > simple-soldier-states.txt
# removed reintroduction of newlines
# | tr '*' $'\n'

#echo "PLAYWRIGHT,STC,TITLE,GENRE,DATE PERFORMANCE,TEXT"
#cat simple-soldier-states.txt | while read match; do
#	tcp=`echo $match | cut -d ':' -f 1 | sed -e "s|ReprocessedSimpleText/||"| cut -d "." -f 1`
#	vep=`echo $match | cut -d ':' -f 1 | sed -e "s|ReprocessedSimpleText/||"| cut -d "." -f 1-2`
#	text=`echo $match | cut -d ':' -f 2- | sed -e "s|\"|\"\",|g"`
#	metadata=`grep ",${vep}.txt," ../VEP_Expanded_Drama_1700_Metadata.csv`
#	date=`grep "$tcp," tcp_dense_integer_publication_dates.csv | cut -d "," -f 2`
#	nl=$'\n'
#
#	echo "$tcp,$vep,$date,\"$text\""
#done

python join.py