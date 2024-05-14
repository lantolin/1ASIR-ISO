#!/bin/bash

# se proponen las siguientes mejoras:
#  1. no funciona bien con ficheros que tengan espacios en el nombre, arreglalo
#  2. no funciona si el fichero md5sum.txt tiene multiples checksums, arreglalo
#  3. acepta un 2o argumento que sea el nombre del fichero de chequeos, pero si no se proporciona que sea md5sum.txt 

if [ $# -ne 1 ]; then 
  echo "USO: $0 <nombre-fichero>"
  exit 2;
fi

F=$1

if [ ! -r ${F} ]; then
  echo "ERROR: no se puede leer [${F}]"
  exit 3;
fi

if [ ! -r md5sum.txt ]; then
  echo "ERROR: no existe fichero de comprobación [md5sum.txt]"
  exit 4;
fi

SUM1=$(md5sum $F)

SUM2=$(cat md5sum.txt)

if [ "${SUM1}" == "${SUM2}" ]; then
  echo "OK"
  exit 0
else
  echo "NOK"
  exit 1;
fi