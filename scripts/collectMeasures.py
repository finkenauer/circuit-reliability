# $ python2 collectMeasures.py > outfile.txt

import mmap
import os
import sys

cwd = os.getcwd()

count = 1
collector = []
toSearch = "Measurement result summary"

for subdir, dirs, files in os.walk(cwd):
    for file in files:
    	if file.endswith(".log"):
	        with open(file, 'rU') as fid:
		        for index, line in enumerate(fid, start=1):
		        	if toSearch in line:
		        		print "\t", count
		        		for i in range(10):	
		        			sys.stdout.write(next(fid))
		        		count = count + 1