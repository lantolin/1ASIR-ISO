#!/bin/bash

BASE=/root/1ASIR-ISO-code/UT4/src/

if ps -fe | grep zombieInfinity | grep -v grep; then
  exit 1
fi

"${BASE}"/stress-ng --cpu-load 60 --cpu 1 &
"${BASE}"/munch2 400 &
for ((i = 1; i <= 20; i++)); do
  "${BASE}"/zombieInfinity &
done
