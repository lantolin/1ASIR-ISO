#!/bin/bash

BASE=/root/1ASIR-ISO-code/UT4/src/

nohup "${BASE}"/stress-ng --cpu-load 60 --cpu 1 &
nohup "${BASE}"/munch2 400 &
for (( i=1; i<=20; i++ ))
do 
 nohup "${BASE}"/zombieInfinity &
done