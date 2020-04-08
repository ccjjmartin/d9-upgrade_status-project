#!/bin/bash

## Point of this script is to make 2 column csv files 
## with the name 'keyword.csv' 
## that contain the 
## 'names-of-all-the-files-in-folder','count-of-the-keyword-appearance-in-that-file'
##

# let's make sure we can execute and access these folders. Issues popped up at one point and this got rid of intermittent error
chmod a+x . ##just make sure

# This is legacy, but I needed an easy way to print a comma, and this was already in place.
# @todo figure out another way to do this? 

OLDIFS=$IFS
IFS=,

## Move to the folder where I am storing the report xml from upgrade_status
## This might e different for you
# @todo ask for directory at beginning?

cd ../d9-module-XML-reports

## Loop through all the xml files in the folder
## and for each, run a report against a keyword check loop.
## Printing things to screen just for keeping an eye on progress reasons.

## First, let's define our keywords

keywords=("deprecated method" "deprecated interface" "deprecated constant" "deprecated function" "deprecated class" "depricated trait" "assertFieldByXPath" "autoloaded" "assertIdentical"  "assertNoText" "does not exist" "deprecate" "drupal_set_message" "entity_get_display" "entity_get_form_display" "entity_view" "Fatal error" "no error" "not found and could not be autoloaded" "severity" "twig" "severity=\"error\"")

echo 'total files present'
ls | wc -l
echo ''
echo "running keyword checks on these files"

for f in *.xml
do 
chmod a+x . ##just make sure

## There are 2 circumstances that it is easier to base on file size rather than grep
## First is zero characters 
##  This is the Parser class of erros that halts composer functioning and breaks tooling
## Second is 37 characters
## those characters are always `<?xml version="1.0"?> <checkstyle/>`
## Not sure why these happen yet (2020-04-08:12:15:00) 

## Get the file size, jjust the first part of the output though, hence the awk
filesizer=`wc -c ${f} | awk '{print $1}'`


if [ ${filesizer} == '0' ]
then
  echo ${f} >> ../testsuite/results/zero-size.csv
elif [ ${filesizer} == '37' ] 
  then
    echo ${f} >> ../testsuite/results/37-size.csv
else
  echo ''

## close the danf if statement
fi

###make the dang csvs already!

  for i in "${keywords[@]}"
  do 
  ## generate filename
  outputfilename=`echo ${i} | sed 's/ /-/g'`
  ## Get keywod count and store in a variable
  grepresultcount=`grep -o "${i}" ${f}  | wc -l`
  ## print the next line of each csv
  echo "${f}${IFS}${grepresultcount}'='${i}"
  echo "${f}${IFS}${grepresultcount}"  >> ../testsuite/results/${outputfilename}.csv  
  ## finish keyword loop
  done


## finish file loop
done

## reset to the original IFS
IFS=$OLDIFS
