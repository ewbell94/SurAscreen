#!/bin/bash
#Written by Eric Bell
#3/15/17
#
#assemblefpt.sh compiles a file of the generated fingerprints of all molecules in a res.txt

FILE="$1"

rm -rf mega.fpt

while read line; do
    ID=`echo "${line}" | sed "s/.*\/\(ZINC[0-9]*\).*/\1/"`
    cat fp4/${ID}.sdf.fpt >> mega.fpt
done <${FILE}