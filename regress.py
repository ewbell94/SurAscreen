#Written by Eric Bell
#2/7/17
#
#regress.py is a regression model trainer that prints the fit and order of the features of a molecule by their weights

from sklearn import linear_model
from sklearn.feature_selection import VarianceThreshold
import numpy as np
from sys import argv
from math import sqrt

#initialize both training and test set
attrlist = []
values=[]
testlist=[]
testvals=[]

if len(argv) < 2:
    print("Need filename argument")
    exit(1)

f = open(argv[1],"r") #argument 1 is the training set file name

#read in the training set
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

t=open(argv[2],"r") #argument 2 is the test set file name

#read in the test set (although the test set is redundant when the mean and sd determination is commented out)
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

#filter out any values that are always 0 or 1, they muddy the fit
sel=VarianceThreshold(threshold=1*(1-1))
sel.fit(attrlist)
variances=sel.variances_
varindex=[] #we need to keep track of the indices, they represent the position in the bit string
for i in range(len(variances)):
    if variances[i] > 0:
        varindex.append(i)

attrlist=sel.transform(attrlist)
testlist=sel.transform(testlist)

#cin=[0.]*len(attrlist[0])
#print(sweights)
#print("Fitting regression")
net = linear_model.LinearRegression() #definition of the regression model
#net=linear_model.Lasso()
#net=linear_model.Ridge()
#net=linear_model.SGDRegressor()
net.fit(attrlist,values)#,coef_init=cin) #training the regression model
rs=net.score(attrlist,values) #determining R^2
#print(net.intercept_)
print(rs) #print R^2

#create the feature/weight list
weights = net.coef_

sortlist=[]  
for i,weight in enumerate(weights):
    sortlist.append([varindex[i],weight])
    #sortlist.append([i,weight])
    
sortlist.sort(key=lambda x: x[1]) #sort the feature/weight list by the weights

#print the sorted list
for i in range(len(sortlist)):
#for i in range(10):
    if sortlist[i][1]!=0:
        print(sortlist[i])

#determines the mean and standard deviation of the distance between the actual point and the predicted binding affininty
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


