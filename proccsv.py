import sys
from re import search

args = sys.argv
if len(args)<3 or len(args)>4:
    print("Incorrect number of arguments")
    exit(1)

try:
    f = open(args[1],"r")
    if len(args) > 2:
        w = open(args[3],"w")
    else:
        w = open("proc.csv","w")
except:
    print("Error opening file")
    exit(1)

def fetchEnergy(mol):
    fi = open(args[2],"r")
    grepline=""
    for line in fi:
        if search(mol,line):
            grepline=line
            break
    if grepline=="":
        return None
    else:
        try:
            energy=grepline.split(" ")[1]
            return energy
        except:
            print("There was a problem processing molecule "+mol+": "+str(sys.exc_info()[0]))
            return None

f.readline() #first line is garbage

for line in f:
    parts = line.split(",")
    for i,part in enumerate(parts):
        parts[i]=part.replace("\"","")
    parts.append(fetchEnergy(parts[0]))
    w.write(parts[0]+","+parts[1].strip()+","+parts[2])

f.close()
w.close()
