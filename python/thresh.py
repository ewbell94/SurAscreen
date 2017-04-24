#Written by Eric Bell
#1/6/17
#
#thresh.py fetches all molecules above a threshold

import sys

args = sys.argv

if len(args) > 2:
    print "No input file specified"
    exit(1)

try:
    f = open(args[1],"r")
except IOError:
    print "File not found"
    exit(1)

threshold = -9.2

newfile = open("thresh.txt","w+")
line = f.readline()
end = line.strip().split(":")[1]
val = float(end.strip().split(" ")[0])
while val <= threshold and line:
    newfile.write(line)
    line = f.readline()
    end = line.strip().split(":")[1]
    val = float(end.strip().split(" ")[0])

f.close()
newfile.close()
