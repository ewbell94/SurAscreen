#!/bin/bash

#Written by Eric Bell
#3/8/17
#
#assemblesdf.sh compiles an sdf file from the molecules listed in a res.txt

FILE="$1"

rm -rf mega.sdf

while read line; do
    ID=`echo "${line}" | sed "s/.*\/\(ZINC[0-9]*\).*/\1/"`
    cat sdfdump/${ID}.sdf >> mega.sdf
done <${FILE}