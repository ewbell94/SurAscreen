#Written by Eric Bell
#2/7/17
#
#regress.py is a neural network trainer that spits out what features of a molecule are most important to predicting a good
from sklearn import linear_model
from sklearn.feature_selection import VarianceThreshold
from sklearn.svm import SVR
import numpy as np
from sys import argv
from math import sqrt
attrlist = []
values=[]
testlist=[]
testvals=[]

if len(argv) < 2:
    print("Need filename argument")
    exit(1)

f = open(argv[1],"r")

#print("Reading files")
for i,line in enumerate(f):
    contents = line.split(",")
    if len(contents) != 3:
        if line != "\n":
            print("Error processing "+contents[0])
        continue
    bitlist=[]
    for char in contents[1]:
        bitlist.append(float(char))
    attrlist.append(bitlist)
    values.append(float(contents[2]))

f.close()
#print(attrlist[0])
#print(len(attrlist[0]))
t=open(argv[2],"r")

for i,line in enumerate(t):
    contents = line.split(",")
    if len(contents) != 3:
        if line != "\n":
            print("Error processing "+contents[0])
        continue
    bitlist=[]
    for char in contents[1]:
        bitlist.append(float(char))
    testlist.append(bitlist)
    testvals.append(float(contents[2]))
    
t.close()

#sweights=[]
#for i in attrlist:
#    sweights.append(float(sum(i))/float(len(i)))

sel=VarianceThreshold(threshold=1*(1-1))
sel.fit(attrlist)
variances=sel.variances_
varindex=[]
for i in range(len(variances)):
    if variances[i] > 0:
        varindex.append(i)

attrlist=sel.transform(attrlist)
testlist=sel.transform(testlist)

cin=[0.]*len(attrlist[0])
#print(sweights)
#print("Fitting regression")
net = linear_model.LinearRegression()
#net=linear_model.Lasso()
#net=linear_model.Ridge()
#net=linear_model.SGDRegressor()
#net=SVR()
net.fit(attrlist,values)#,coef_init=cin)
rs=net.score(attrlist,values)
#print(net.intercept_)
print(rs)

weights = net.coef_

sortlist=[]  
for i,weight in enumerate(weights):
    sortlist.append([varindex[i],weight])
    #sortlist.append([i,weight])
    
sortlist.sort(key=lambda x: x[1])

for i in range(len(sortlist)):
#for i in range(10):
    if sortlist[i][1]!=0:
        print(sortlist[i])
'''
mean=0
var=0
for i,item in enumerate(testlist):
    pred = net.predict([item])[0]
    actual = testvals[i]
    #print(actual)
    #print(actual-pred)
    mean+=actual-pred
    var+=(actual-pred)**2

print("Mean: "+str(mean/len(testlist)))
print("SD: "+str(sqrt(var/(len(testlist)-1))))
'''


