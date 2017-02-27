#!/bin/bash
#Written by Eric Bell
#10/13/16
#Fetchlib fetches tar files from the sciurus server and unzips them

#download each file from sciurus
for arg in "$@"; do
    scp ebell@sciurus.hpc.oberlin.edu:~/zinc/${arg}.tar.gz ~/ZINC
done

#unzip each file
for arg in "$@"; do
    for thing in ${arg}; do
	tar -zxf ~/ZINC/${thing}.tar.gz
    done
done
