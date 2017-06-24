#!python
from sys import argv
from sys import stdout
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
		vep_metadata[argv[1] + '/' + row['text_name']] = row
if len(argv) > 2:
	out = open(argv[2], 'w')
else:
	out = stdout
writer = csv.writer(out, lineterminator="\n")
writer.writerow(['PLAYWRIGHT','STC','TITLE','GENRE','DATE PERFORMANCE','TEXT','COLLECTION?'])
with open('simple-soldier-states.txt', 'r') as matches:
	buf = []
	for line in matches:
		if line == "--\n":
			if key == None: continue
			if len(buf) == 0: continue
			match = "".join(buf).strip()
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
			writer.writerow([author, stc, title, genre, date, match, not key.endswith('headed.txt')])
			buf = []
		else:
			key, match = re.split('\.txt[-:]',line,1)
			key = key + '.txt'
			if line.endswith('.txt-\n'): continue
			buf.append(match)
if len(argv) > 2:
	out.close
