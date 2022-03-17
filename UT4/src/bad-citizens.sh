#!/bin/bash

### TODO: hay que mejorar esto para que solo cree los problemas si no existen ya


BASE=/root/1ASIR-ISO/UT4/src/

stress-ng --cpu-load 60 --cpu 1 &

"${BASE}"/munch2 400 &

if ! ps -fe | grep soyUnProceso | grep -v grep; then
  for ((i = 1; i <= 20; i++)); do
    "${BASE}"/soyUnProceso &
  done
fi


