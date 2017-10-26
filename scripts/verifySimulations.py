import mmap
import os

# measureFiles = []
wrongFiles = []
count = 0

cwd = os.getcwd()

for subdir, dirs, files in os.walk(cwd):
    for file in files:
        if file.endswith(".log"):
        	file = os.path.join(subdir, file)
        	# measureFiles.append(file)
        	with open(file) as fid:
 				string = mmap.mmap(fid.fileno(), 0, access=mmap.ACCESS_READ)
 				if string.find('pHL_Sv_case1') != -1:
 					count = count + 1
 				else:
 					wrongFiles.append(file)

wfilesString = str(wrongFiles)

textFile = open("Output.txt", "w")
textFile.write("Numero de arquivos corretos: %s \n" % count)
textFile.write("Arquivos com erro: \n")
for path in wfilesString.split(","):
	textFile.write(path)
	textFile.write("\n")
textFile.close()