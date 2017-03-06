#Written by Eric Bell
#6/21/16
#
#energystats.py returns the mean and SD of the binding affinities of a res.txt

import sys
import math

try:
    file = open(sys.argv[1],"r")
except Exception as e:
    print "File unable to be opened"
    print e
    sys.exit(1)

energ = []
for line in file:
    try:
        energ.append(float(line.split()[1]))
    except:
        continue
file.close()

mean = math.fsum(energ)/float(len(energ))
print "Mean: "+str(mean)

deviation = 0.0

for val in energ:
    resid = val-mean
    var = resid ** 2
    deviation += var

variance = deviation / float(len(energ)-1)

sd = math.sqrt(variance)

print "SD: "+str(sd)

