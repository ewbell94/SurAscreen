#!/bin/bash

FILE="$1"

rm -rf mega.sdf

while read line; do
    ID=`echo "${line}" | sed "s/.*\/\(ZINC[0-9]*\).*/\1/"`
    cat sdfdump/${ID}.sdf >> mega.sdf
done <${FILE}