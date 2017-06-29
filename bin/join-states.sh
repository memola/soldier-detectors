#!/bin/bash
export histchars='¡^'
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

$bindir/egrep-soldier-assert-present.sh $1 | tr $'\n' '*' | sed -e $'s|*'$DIR'|'$'\\\n'$DIR'|g' | sed -e 's|\**$||' | sed -e 's|\s*$||' > $tmpdir/working-soldier-states1.txt
found=`wc -l $tmpdir/working-soldier-states1.txt`
echo "found $found lines total"
$bindir/egrep-soldier-assert-past.sh $1 | tr $'\n' '*' | sed -e $'s|*'$DIR'|'$'\\\n'$DIR'|g' | sed -e 's|\**$||' | sed -e 's|\s*$||' > $tmpdir/working-soldier-states2.txt
found=`wc -l $tmpdir/working-soldier-states2.txt`
echo "found $found lines total"
$bindir/egrep-gentleman-assert.sh $1 | tr $'\n' '*'| sed -e $'s|*'$DIR'|'$'\\\n'$DIR'|g' | grep -i soldier  | sed -e 's|\**$||' | sed -e 's|\s*$||' > $tmpdir/working-soldier-states3.txt
found=`wc -l $tmpdir/working-soldier-states3.txt`
echo "found $found lines total"
cat $tmpdir/working-soldier-states1.txt $tmpdir/working-soldier-states2.txt $tmpdir/working-soldier-states3.txt | sort | uniq > $tmpdir/simple-soldier-states.txt

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
echo "${prefix}soldier.csv"
python $bindir/join.py $1 $tmpdir/simple-soldier-states.txt "${prefix}soldier.csv"
unset histchars