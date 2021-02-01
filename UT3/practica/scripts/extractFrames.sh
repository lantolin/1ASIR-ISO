#!/bin/bash

fichero=${1}
directorio=$(basename "${fichero}")
shift

mkdir "${directorio}"
cd "${directorio}"

for minutos in $(seq $*) ; do
#for minutos in 02 05 10 20 25 ; do
  mplayer -vo jpeg -nojoystick -nolirc -nosound -ss 00:${minutos}:00 -frames 1 "${fichero}"
  mv 00000001.jpg 00:${minutos}:00.jpg 
done
cd -
