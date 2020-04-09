#!/bin/bash

OLDIFS=$IFS
IFS=,

cd results

echo 'total files present' >> ../SUMMARY-COUNT.csv
ls | wc -l >> ../SUMMARY-COUNT.csv
echo '' >> ../SUMMARY-COUNT.csv


for f in *.csv
do 

COUNTNON0=`grep -v ',0' ${f} | wc -l`
echo "${f}${IFS}${COUNTNON0}" >> ../SUMMARY-COUNT.csv

done 

## reset to the original IFS
IFS=$OLDIFS
