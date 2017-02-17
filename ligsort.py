#Written by Eric Bell
#6/2/16
#
#ligsort.py takes a results file from sort.sh, sorts it by top confirmation energy value and prints the top n results
import sys

#sys.setrecursionlimit(10 ** 6) #prevents recursion depth errors

try: #checks that file is openable
    file = open(sys.argv[1]+"/res.txt","r")
except Exception as e:
    print "File unable to be opened"
    print e
    sys.exit(1)

ligs=[]
for line in file: #splits the data into name and energy value
    tokens=line.split(" ")
    try:
        tokens[1]=float(tokens[1])
        ligs.append(tokens)
    except:
        continue

file.close()

ligs.sort(key=lambda atom: atom[1]) #sort the data
try: #look if there's an argument, if not or if its wrong, set it to 10
    numres=int(sys.argv[2])
    if numres > len(ligs):
        numres=len(ligs)
except:
    numres=10

for i in range(0,numres-1): #print the top scorers
    print ligs[i][0]+": "+str(ligs[i][1])+" kcal/mol"
