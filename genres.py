#Written by Eric Bell
#1/4/2017
#
#genres.py is a program that takes a file containing a list of zinc subsets and outputs an html file consisting of details of the compounds listed

import sys
import os
from urllib import urlopen

#the energetic threshold of a "hit" in kcal/mol
threshold =-9.2

#checks for argument count
args = sys.argv
if len(args) != 2:
    print "Incorrect number of arguments, exiting..."
    exit(1)

#opens the file
try:
    f = open(args[1],"r")
except:
    print "File not found.  Exiting..."
    exit(1)

cwd = os.getcwd() #current directory, to return to later, should contain ZINC directory
#print cwd

reslist = [] #will hold the results for sorting

for line in f: #for each line in input
    line2 = line.strip()
    #print cwd+"/ZINC/"+line2
    os.chdir(cwd+"/ZINC/"+line2)
    fi = open("final.txt","r")
    lin = fi.readline().strip().replace(".",line2,1)
    #print lin
    end = lin.split(":")[1]
    val = float(end.split(" ")[1]) #glean energy from final.txt
    while val <= threshold: #while the energy values are above the specified threshold
        reslist.append([lin,val]) #add results to be sorted later
        lin = fi.readline().strip().replace(".",line2,1)
        #print lin
        end = lin.split(":")[1]
        val = float(end.split(" ")[1])
    fi.close()
    os.chdir(cwd)

#for result in reslist:
    #print result

reslist.sort(key=lambda tup: tup[1]) #sort the results list
    
res = open("results.html","w+") #opens html file

res.write("<link href=\"style.css\" rel=\"stylesheet\" type=\"text/css\">\n")#link to stylesheet
    
for lin,val in reslist:
    res.write("<h3>"+lin.strip()+"</h3>\n") #write header
    idnum = lin.split("/")[2].replace("ZINC","")
    res.write("<a href=\"http://zinc.docking.org/substance/"+idnum+"\">ZINC Entry</a></br>\n") #write zinc link
    res.write("<img src=\"http://zinc.docking.org/img/sub/"+idnum+".gif\" /></br>\n") #fetch image
    try:
        errcount = 0
        page = urlopen("http://zinc.docking.org/substance/"+idnum) #look for vendor table
        nextlin = page.readline().strip()
        #print nextlin
        res.write("<h4>Annotations</h4>\n")
        while nextlin != "<ul class=\"annotated catalogs\">" and nextlin != "<ul class=\"purchasable catalogs\">":
            nextlin = page.readline().strip()
            #print nextlin
            if not nextlin:
                errcount +=1
                if errcount > 10:
                    break
            else:
                errcount = 0
        if errcount > 10:
            continue
        while nextlin != "</ul>" and nextlin != "<ul class=\"purchasable catalogs\">" and nextlin: #write annotation table
            res.write(nextlin+"\n")
            #print "caught: "+nextlin
            nextlin = page.readline().strip()
        if nextlin != "<ul class=\"purchasable catalogs\">":
            res.write("</ul>\n") #finish the unordered list
        res.write("<h4>Vendors</h4>\n")
        while nextlin != "<ul class=\"purchasable catalogs\">":
            nextlin = page.readline().strip()
            #print nextlin
        while nextlin != "</ul>" and nextlin: #write the vendor table
            res.write(nextlin+"\n")
            #print "caught: "+nextlin
            nextlin = page.readline().strip()
        res.write("</ul>\n") #finish the unordered list
        page.close()
    except IOError:
        print "Could not open zinc page for id: "+idnum
        
f.close()
res.close()
