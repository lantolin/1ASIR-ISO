#!/bin/bash 

if [[ -z $UNA_VARIABLE ]]; then
   UNA_VARIABLE=42
fi
export UNA_VARIABLE

if [[ -z $OTRA_VARIABLE ]]; then
   OTRA_VARIABLE="cuarenta y dos"
fi
export OTRA_VARIABLE

echo "** PHP **"
php env.php
echo

echo "** Javascript **"
node env.js
echo

echo "** C **"
gcc env.c -o env && ./env
echo

echo "** C++ **"
g++ env.cpp -o env-cpp && ./env-cpp
echo

echo "** Java **"
java Env.java
echo

echo "** Perl **"
perl env.pl
echo

echo "** Ruby **"
ruby env.rb
echo

echo "** Python **"
python env.py 
echo
