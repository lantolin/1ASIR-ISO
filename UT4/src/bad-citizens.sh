#!/bin/bash

### TODO: hay que mejorar esto para que solo cree los problemas si no existen ya

BASE=/root/1ASIR-ISO/UT4/src/
LOG=/tmp/bad-citizens.log

echo "INICIO $(date +"%Y-%m-%d_%H.%M.%S")" >>${LOG}

if ps -fe | grep stress-ng | grep -v grep; then
  echo "stress-ng ya esta corriendo" >>${LOG}
else
  echo "stress-ng se lanza" >>${LOG}
  stress-ng --cpu-load 70 --cpu 1 &
fi

if ps -fe | grep munch | grep -v grep; then
  echo "munch ya esta corriendo" >>${LOG}
else
  echo "munch se lanza" >>${LOG}
  "${BASE}"/munch2 430 &
fi

NUM_ZOMBIS=$(ps -e -O status | grep -w Z | grep -v grep | wc -l)
echo "NUM_ZOMBIS=${NUM_ZOMBIS}" >>${LOG}

if [[ $NUM_ZOMBIS -gt 50 ]]; then
  echo "suficientes zombis"  >>${LOG}
else
  echo "añadiendo zombis" >>${LOG}
  if ! ps -fe | grep soyUnProceso | grep -v grep; then
    for ((i = 1; i <= 50; i++)); do
      "${BASE}"/soyUnProceso &
    done
  fi
fi

echo "FIN $(date +"%Y-%m-%d_%H.%M.%S")" >>${LOG}
