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
with open('VEP_EM1080_Metadata.csv','r') as csvfile:
	metadata = csv.DictReader(csvfile)
	# TCP,ESTC,text_name,Title,Title 30 Char or fewer,Author,Physical Description,
	# Phys Desc Notes,Derived Date,Publication Place,Publisher,Verse/Prose/Mixed,
	# Helsinki Prototypical Text Category,Non-Helsinki Prototypical,Status,Notes

	for row in metadata:
		if row['text_name'] in vep_metadata: continue
		new_row = {}
		new_row['author'] = row['Author']
		new_row['date of 1st performance'] = row['Derived Date']
		new_row['text_name'] = row['text_name']
		new_row['stc'] = row['ESTC']
		new_row['title'] = row['Title 30 Char or fewer']
		new_row['DEEP genre'] = row['Verse/Prose/Mixed']
		vep_metadata[row['text_name']] = new_row

if len(argv) > 3:
	out = open(argv[3], 'w')
else:
	out = stdout
writer = csv.writer(out, lineterminator="\n")
writer.writerow(['PLAYWRIGHT','STC','TITLE','GENRE','DATE PERFORMANCE','1080 DECADE','TEXT','COLLECTION?','FILE'])
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
		decade = metadata.get('decade', '')
		if len(decade) == 0 and len(date) > 0:
			year = int(date)
			decade = str(year - (year % 10))
		decade_1080 = '%4d:::%4d' % (int(decade), int(decade) + 9)
		stc = metadata.get('estc', '')
		title = metadata['title']
		file_name = metadata.get('text_name',key)
		writer.writerow([author, stc, title, genre, date, decade_1080, match.strip(), not key.endswith('headed.txt'), file_name])
if len(argv) > 3:
	out.close
