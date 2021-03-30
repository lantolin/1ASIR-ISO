#!/bin/bash

nohup ./stress-ng --cpu-load 60 --cpu 1 &
nohup ./munch2 400 &
for (( i=1; i<=20; i++ ))
do 
 nohup  ./zombieInfinity &
done