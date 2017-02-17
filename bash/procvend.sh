#Written by Eric Bell
#6/16/16
#
#Procres.sh does all the processing of a result from a raccoon screen

#!/bin/bash

echo "Fetching" #fetch tar.gz from supercomputer
for arg in "$@"; do
    scp ebell@sciurus.hpc.oberlin.edu:~/raccoon/data/Vend/${arg}/dP2--${arg}/dP2--${arg}.tar.gz ~/Vend
done

for arg in "$@"; do
    echo "Unzipping" #unzip the tar.gz to its own directory
    cd Vend
    mkdir ${arg}
    mv dP2--${arg}.tar.gz ${arg}
    cd ${arg}
    tar -zxf dP2--${arg}.tar.gz
    cd

    echo "Sorting" #use sort.sh to print out the top 20 results
    ./sort.sh Vend/${arg} 20 > Vend/${arg}/final.txt
    #python scaleatom.py ${arg}

    echo "Done!"
done
