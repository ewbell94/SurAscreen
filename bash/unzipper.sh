#!/bin/bash

#Written by Eric Bell
#6/13/16
#
#unzipper.sh unzips the .sdf.gz files from ZINC12 and turns them into zipped directories (.tar.gz)

for var in "$@"; do #allows multiple arguments to be passed, runs on each of them

FNAME=`echo $var | sed "s/.sdf.*//"` #gets name with no extensions
mkdir $FNAME #makes directory for the sdf file
cat ${FNAME}.sdf.gz > ${FNAME}/${FNAME}.sdf.gz #copies zipped file to directory
cd $FNAME

echo "Unzipping..."
gzip -d ${FNAME}.sdf.gz #unzips sdf
COUNT=`grep '\$\$' ${FNAME}.sdf | wc -l` #gets total molecule number for percentages later

echo "Splitting..."
csplit -n 6 ${FNAME}.sdf '/\$\$/+1' '{*}' | { #splits the composite sdf into smaller sdfs
    PROG="0"; #counts the file outputs and reports percentage completion
    while read; do
	PROG=`expr ${PROG} + 1`;
	TEMP=`expr ${PROG} \* 100`;
	PERC=`expr ${TEMP} / ${COUNT}`;
	echo -en "${PERC}%\r";
    done;
    echo "";
}

echo "Renaming..."
PROG="0"
for file in `ls`; do
    if [ -f $file ]; then #renames files based on its ZINC id listed inside the file
	PROG=`expr ${PROG} + 1`
	NAME=`grep 'ZINC' "$file"`
	mv ${file} ${NAME}.sdf
	if [ `expr ${PROG} % 100` -eq "0" ]; then #reports percentage completion
	    PERC=`expr ${PROG} \* 100 / ${COUNT}`
	    echo -en "${PERC}%\r"
	fi
     fi
done
PROG="0"

echo "Converting..."
obabel *.sdf -o pdbqt -m #converts all sdf files to pdbqt in one command

echo "Cleaning..."
for file in `ls | grep 'sdf'`; do #removes all lingering sdf files
    rm -f $file 
done

mkdir more

echo "Moving..."
for file in `ls | grep 'ZINC[5-9]'`; do #moves some of the files to limit job array size
    mv $file more/$file
done

echo "Compressing..." #recompresses the directory to a .gz file for scp transfer
cd ../
tar -zcf ${FNAME}.tar.gz ${FNAME}
echo "Done!"

done