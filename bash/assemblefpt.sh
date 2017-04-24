#!/bin/bash

FILE="$1"

rm -rf mega.fpt

while read line; do
    ID=`echo "${line}" | sed "s/.*\/\(ZINC[0-9]*\).*/\1/"`
    cat fp4/${ID}.sdf.fpt >> mega.fpt
done <${FILE}