#!python
from sys import argv
from sys import stdout
from os.path import basename
import csv
import re
vep_metadata = {}
with open('VEP_Expanded_Drama_1700_Metadata.csv','r') as csvfile:
	metadata = csv.DictReader(csvfile)
	# TCP,estc,Wiggins number,author,author 2,
	# author 3,author 4,author 5,translator,adaptation,
	# missing or excluded from TCP,title,alternative title,type,genre,
	# Wiggins genre,DEEP genre,Harbage genre,Wiggins contemporary genre,date of writing,
	# decade,date of 1st performance,Harbage limits of performance date,date of 1st publication,date of text used,
	# play company 1,play company 2,theatre,metre,rhyme,
	# notes,text_name,status

	for row in metadata:
		vep_metadata[row['text_name']] = row
if len(argv) > 3:
	out = open(argv[3], 'w')
else:
	out = stdout
writer = csv.writer(out, lineterminator="\n")
writer.writerow(['PLAYWRIGHT','STC','TITLE','GENRE','DATE PERFORMANCE','TEXT','COLLECTION?','FILE'])
with open(argv[2], 'r') as matches:
	buf = []
	for line in matches:
		key, match = line.split(':',1)
		key = basename(key)
		metadata = vep_metadata.get(key)
		if metadata == None:
			print "no metadata entry for " + key
			metadata = {'title': key}
		author = metadata.get('author', '')
		author = author + ';' + metadata.get('author 2','')
		author = author + ';' + metadata.get('author 3','')
		author = author + ';' + metadata.get('author 4','')
		author = author + ';' + metadata.get('author 5','')
		author = author.strip(';')
		genre = metadata.get('DEEP genre', '')
		date = metadata.get('date of 1st performance', '')
		stc = metadata.get('estc', '')
		title = metadata['title']
		file_name = metadata.get('text_name','')
		writer.writerow([author, stc, title, genre, date, match.strip(), not key.endswith('headed.txt'), file_name])
if len(argv) > 3:
	out.close
