from sys import argv
import random

if len(argv) > 4 or len(argv) < 3:
    print("Improper argument count")
    exit(1)

try:
    f=open(argv[1],"r")
except:
    print("File not opened")
    exit(1)

lines=f.readlines()
random.shuffle(lines)
try:
    itercount=int(argv[3])
except:
    itercount=1

for i in range(0,itercount):
    w=open("set"+str(i)+".txt","w")
    for j in range(0,int(argv[2])):
        w.write(lines[i*int(argv[2])+j])
    w.close()
