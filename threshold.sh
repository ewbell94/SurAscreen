#!/bin/bash

#Written by Eric Bell
#6/2/16
#
#Threshold.sh takes a directory with results from Raccoon2 and outputs the files with top confirmations lower than the specified threshold.

DIR=$1 #argument of where the "0" directory is
if [ "$2" = "" ]; then #sets threshold argument if one is provided, otherwise is set to the default
    THRESH="-8"
else
    THRESH=$2
fi

cd "$DIR"
for RESULT in `ls .`; do
    cd $RESULT
    VAL=`grep 'REMARK VINA RESULT' "${RESULT}_out.pdbqt" | 
         head -n 1 | 
         sed "s/REMARK VINA RESULT://" | 
	 sed 's/\.\([0-9]\).*/\.\1/'` #extract the energy value from the pdbqt file
    TESTVAL=`echo ${VAL} | sed 's/\..*//'` #truncate the value to an int for testing
    if [ "${TESTVAL}" -le "${THRESH}" ]; then
	echo ${RESULT}: ${VAL} kcal/mol 
    fi
    cd ../
done