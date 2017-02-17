#!/bin/sh

for lib in "$@"; do
    OBS=`locate ~/ZINC/${lib}/*_out.pdbqt -c`
    EXP=`cat ~/ZINC/${lib}/job.index | wc -l`
    DIFF=`expr ${EXP} - ${OBS}`
    if [ ${DIFF} -eq "0" ]; then
	echo "${lib} is valid."
    else
	echo "${lib} is not valid, missing ${DIFF} compounds."
    fi
done
