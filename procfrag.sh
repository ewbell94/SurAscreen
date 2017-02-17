#Written by Eric Bell
#6/16/16
#
#Procres.sh does all the processing of a result from a raccoon screen

#!/bin/bash

echo "Fetching" #fetch tar.gz from supercomputer
scp ebell@sciurus.hpc.oberlin.edu:~/raccoon/data/Frag/${1}/dP2--${1}/dP2--${1}.tar.gz ~/FRAG

echo "Unzipping" #unzip the tar.gz to its own directory
cd FRAG
mkdir ${1}
mv dP2--${1}.tar.gz ${1}
cd ${1}
tar -zxf dP2--${1}.tar.gz
cd


echo "Sorting" #use sort.sh to print out the top 20 results
./sort.sh ~/FRAG/${1} 20 > ~/FRAG/${1}/final.txt
#python scaleatom.py ${1}

echo "Done!"
