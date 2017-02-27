#Written by Eric Bell
#1/18/17
#
#randomset.py generates random sets of molecules from a res-like file

from sys import argv
import random

if len(argv) > 4 or len(argv) < 3:
    print("Improper argument count")
    exit(1)

try:
    f=open(argv[1],"r") #open res.txt file
except:
    print("File not opened")
    exit(1)

lines=f.readlines() #get all lines of the file
random.shuffle(lines) #shuffle all lines of the file
try:
    itercount=int(argv[3]) #the amount of sets to be generated
except:
    itercount=1

#create each set from shuffled lines
for i in range(0,itercount):
    w=open("set"+str(i)+".txt","w")
    for j in range(0,int(argv[2])): #argument 2 is the size of the set
        w.write(lines[i*int(argv[2])+j])
    w.close()
