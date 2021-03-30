#!/bin/bash

./stress-ng --cpu-load 60 --cpu 1 &
./munch2 400 &
for (( i=1; i<=20; i++ ))
do 
  ./zombieInfinity
done