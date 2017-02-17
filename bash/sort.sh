#!/bin/bash
#Written by Eric Bell
#6/2/16
#
#sort.sh takes results from a Raccoon2 screen and sorts them using a python script and prints out the top n results

DIR=$1 #argument of where the "0" directory is
if [ "$DIR" = "" ]; then
    echo "No directory argument found"
    exit
fi
if [ "$2" = "" ]; then #sets amount of results argument if provided, otherwise is default
    NUMLIG="10"
else
    NUMLIG=$2
fi

cd "$DIR"
rm -rf res.txt #clears any lingering results text files

echo -n "" > res.txt

find . -type f -name "*_out.pdbqt" > list.txt

#splitting up the for loop allows for multithreading

for RESULT in `grep "0_out" 'list.txt'`; do    
    VAL=`grep -m1 'REMARK VINA RESULT' "${RESULT}" |  
         sed -e "s/REMARK VINA RESULT://" -e 's/\.\([0-9]\).*/\.\1/'` #extract the energy value from the pdbqt file
    echo ${RESULT} ${VAL} >> res.txt #append the molecule info to results
done &

for RESULT in `grep "1_out" 'list.txt'`; do    
    VAL=`grep -m1 'REMARK VINA RESULT' "${RESULT}" | 
         sed -e "s/REMARK VINA RESULT://" -e 's/\.\([0-9]\).*/\.\1/'` #extract the energy value from the pdbqt file
    echo ${RESULT} ${VAL} >> res.txt #append the molecule info to results
done &

for RESULT in `grep "2_out" 'list.txt'`; do    
    VAL=`grep -m1 'REMARK VINA RESULT' "${RESULT}" | 
         sed -e "s/REMARK VINA RESULT://" -e 's/\.\([0-9]\).*/\.\1/'` #extract the energy value from the pdbqt file
    echo ${RESULT} ${VAL} >> res.txt #append the molecule info to results
done &

for RESULT in `grep "3_out" 'list.txt'`; do    
    VAL=`grep -m1 'REMARK VINA RESULT' "${RESULT}" |  
         sed -e "s/REMARK VINA RESULT://" -e 's/\.\([0-9]\).*/\.\1/'` #extract the energy value from the pdbqt file
    echo ${RESULT} ${VAL} >> res.txt #append the molecule info to results
done &

for RESULT in `grep "4_out" 'list.txt'`; do    
    VAL=`grep -m1 'REMARK VINA RESULT' "${RESULT}" |  
         sed -e "s/REMARK VINA RESULT://" -e 's/\.\([0-9]\).*/\.\1/'` #extract the energy value from the pdbqt file
    echo ${RESULT} ${VAL} >> res.txt #append the molecule info to results
done &

for RESULT in `grep "5_out" 'list.txt'`; do    
    VAL=`grep -m1 'REMARK VINA RESULT' "${RESULT}" |  
         sed -e "s/REMARK VINA RESULT://" -e 's/\.\([0-9]\).*/\.\1/'` #extract the energy value from the pdbqt file
    echo ${RESULT} ${VAL} >> res.txt #append the molecule info to results
done &

for RESULT in `grep "6_out" 'list.txt'`; do    
    VAL=`grep -m1 'REMARK VINA RESULT' "${RESULT}" | 
         sed -e "s/REMARK VINA RESULT://" -e 's/\.\([0-9]\).*/\.\1/'` #extract the energy value from the pdbqt file
    echo ${RESULT} ${VAL} >> res.txt #append the molecule info to results
done &

for RESULT in `grep "7_out" 'list.txt'`; do    
    VAL=`grep -m1 'REMARK VINA RESULT' "${RESULT}" | 
         sed -e "s/REMARK VINA RESULT://" -e 's/\.\([0-9]\).*/\.\1/'` #extract the energy value from the pdbqt file
    echo ${RESULT} ${VAL} >> res.txt #append the molecule info to results
done &

for RESULT in `grep "8_out" 'list.txt'`; do    
    VAL=`grep -m1 'REMARK VINA RESULT' "${RESULT}" |  
         sed -e "s/REMARK VINA RESULT://" -e 's/\.\([0-9]\).*/\.\1/'` #extract the energy value from the pdbqt file
    echo ${RESULT} ${VAL} >> res.txt #append the molecule info to results
done &

for RESULT in `grep "9_out" 'list.txt'`; do    
    VAL=`grep -m1 'REMARK VINA RESULT' "${RESULT}" |  
         sed -e "s/REMARK VINA RESULT://" -e 's/\.\([0-9]\).*/\.\1/'` #extract the energy value from the pdbqt file
    echo ${RESULT} ${VAL} >> res.txt #append the molecule info to results
done &

wait

rm -f list.txt
cd
python ligsort.py ${DIR} ${NUMLIG} #run the sorting program
#rm -rf res.txt #remove the intermediate results file
