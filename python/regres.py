#Written by Eric Bell
#2/16/16
#
#regres.py takes multiple runs of regress.py and compiles them into one "score" of the features

from sys import argv
from math import sqrt


fits=[] #keeps track of fits (R^2)
scores=[0]*1024 #keeps track of sums of the weights weighted by the fit

#add the weight multiplied by the fit to the score of each feature (those with worse fits are worth less)
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

#create the final feature/weight list
final=[]
for i,score in enumerate(scores):
    if score != 0:
        final.append([i,score])

final.sort(key=lambda x: x[1]) #sort the final feature/weight list

#print the sorted final list
for i in final:
    print(i)

#print mean R^2 and the SD on that value
meanfit=sum(fits)/len(fits)
var=0
for i in fits:
    var+=(meanfit-i)**2
sd=sqrt(var/(len(fits)-1))

print(meanfit)
print(sd)