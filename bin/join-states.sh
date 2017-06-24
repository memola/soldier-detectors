#!/bin/bash
DIR=`dirname $1`
if [ $DIR = '.' ]; then
	DIR=$1
	prefix=""
else
	prefix=`echo $DIR | sed -e $'s|/|__|g'`
	prefix="${prefix}_"
fi

./egrep-soldier-assert-present.sh $1 | tr $'\n' '*' | sed -e $'s|*'$DIR'|'$'\\\n'$DIR'|g' > working-soldier-states1.txt
found=`wc -l working-soldier-states1.txt`
echo "found $found lines total"
./egrep-soldier-assert-past.sh $1 | tr $'\n' '*' | sed -e $'s|*'$DIR'|'$'\\\n'$DIR'|g' > working-soldier-states2.txt
found=`wc -l working-soldier-states2.txt`
echo "found $found lines total"
./egrep-gentleman-assert.sh $1 | tr $'\n' '*' | sed -e $'s|*'$DIR'|'$'\\\n'$DIR'|g' | grep -i soldier > working-soldier-states3.txt
found=`wc -l working-soldier-states3.txt`
echo "found $found lines total"
cat working-soldier-states1.txt working-soldier-states2.txt working-soldier-states3.txt | sort | uniq > simple-soldier-states.txt

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

echo "${prefix}soldier-post1642.csv"
python join.py $1 "${prefix}soldier-post1642.csv"