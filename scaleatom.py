#Written by Eric Bell
#6/17/16
#
#Scaleatom.py reads an output from sort.sh and prints out the top 20's binding energies divided by the docked molecules' total atom count

import sys

direct=sys.argv[1]
try:
    res = open("./ZINC/"+direct+"/final.txt","r")
    div = open("./ZINC/"+direct+"/div.txt","w")
except Exception as e:
    print "Error opening final.txt"
    print e
    exit(1)

for line in res:
    parts=line.split()
    val = float(parts[1])
    f = parts[0][2:len(parts[0])-1]
    try:
        pdbqt = open("./ZINC/"+direct+"/"+f,"r")
    except Exception as e:
        print e
    count = 0
    ln = pdbqt.readline().rstrip('\n')
    while ln != "ENDMDL":
        if ln[0:4] == "ATOM":
            count+=1
        ln = pdbqt.readline().rstrip('\n')
    pdbqt.close()
    div.write(f+": "+str(val/float(count))+" kcal/atom-mol\n")
    
res.close()
div.close()
