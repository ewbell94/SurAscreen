from sys import argv
from math import sqrt

fits=[]
scores=[0]*1024

for fname in argv[1:]:
    f=open(fname,"r")
    fit=float(f.readline())
    fits.append(fit)
    for line in f:
        pair=line.split(',')
        pair[0]=int(pair[0].replace("[",""))
        pair[1]=float(pair[1].strip().replace("]",""))
        scores[pair[0]]+=fit*pair[1]
    f.close()

final=[]
for i,score in enumerate(scores):
    if score != 0:
        final.append([i,score])

final.sort(key=lambda x: x[1])

for i in final:
    print(i)

meanfit=sum(fits)/len(fits)
var=0
for i in fits:
    var+=(meanfit-i)**2
sd=sqrt(var/(len(fits)-1))

print(meanfit)
print(sd)