#!/bin/bash

# Test the number of arguments.

if [[ $# -ne 2 ]];
then 
  echo "jpegRotate right|left|180 <file_name>" ; 
  exit 1 ;
fi

# Test the existence and readability of the file

if [[ ! -r "${2}" ]];
then 
  echo "Can't read file $2" ;
  exit 2;
fi

# Create a temporary safe filename

temporary=`mktemp "${2}".XXXXXX`

# Enough of testing, let's rotate it.

case $1 in
  "right") jpegtran -rotate 90 -copy all -outfile "${temporary}" "${2}" ;;
  "left") jpegtran -rotate 270 -copy all -outfile "${temporary}" "${2}" ;;
  "180") jpegtran -rotate 180 -copy all -outfile "${temporary}" "${2}" ;;
  *) echo "jpegRotate right|left|180 <file_name>" ; exit 1 ;
esac

# If everything was OK then overwrite the old file.

if [[ $? -ne 0  ]];
then 
  echo "Error using jpegtran.";
  exit 3;
fi;

if [[ ! -r "${temporary}" ]];
then 
  echo "Error, jpegtran produced no output file.";
  exit 4;
fi;

\mv -f "${temporary}" "${2}"
