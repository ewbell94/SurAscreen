#!/usr/bin/bash
#Written by Eric Bell
#6/16/16
#
#Procres.sh does all the processing of a result from a raccoon screen

echo "Fetching" #fetch tar.gz from supercomputer
for arg in "$@"; do
    scp ebell@sciurus.hpc.oberlin.edu:~/raccoon/data/Zinc/${arg}/dP2--${arg}/dP2--${arg}.tar.gz ~/ZINC
done

for arg in "$@"; do
    echo "Unzipping" #unzip the tar.gz to its own directory
    cd ZINC
    mkdir ${arg}
    mv dP2--${arg}.tar.gz ${arg}
    cd ${arg}
    tar -zxf dP2--${arg}.tar.gz
    cd

    echo "Sorting" #use sort.sh to print out the top 1000 results
    ./sort.sh ZINC/${arg} 1000 > ZINC/${arg}/final.txt
    python scaleatom.py ${arg}

    echo "Done!"
done
