#!/bin/bash

# ejemplo
# /tmp/tests-locales-1ASIR-ISO.sh 08:00:27:1c:23:00 0 lantolin lantolin.1asir.bu.gsd.com

MAC="$1"
NUM_LISTA="$2"
ID1="$3"
DOMINIO="$4"

BASE_PRACTICAS=$HOME/ISO

source /tmp/tests-comun.sh

function PG_LINUSR_escape() {
  echo -ne "== PG LINUSR.03 escape\n"
  local_dir "$BASE_PRACTICAS/PG.LINUSR03_escape/tmp/uno dos tres"
  local_dir "$BASE_PRACTICAS/PG.LINUSR03_escape/tmp/uno;dos;tres"
  local_dir "$BASE_PRACTICAS/PG.LINUSR03_escape/tmp/uno\"dos\"tres"
  local_dir "$BASE_PRACTICAS/PG.LINUSR03_escape/tmp/uno\$dos\$tres"
  local_dir "$BASE_PRACTICAS/PG.LINUSR03_escape/tmp/uno\$PWD"
  local_dir "$BASE_PRACTICAS/PG.LINUSR03_escape/tmp/uno\\dos\\tres"
  local_dir "$BASE_PRACTICAS/PG.LINUSR03_escape/tmp2/uno dos tres"
  local_dir "$BASE_PRACTICAS/PG.LINUSR03_escape/tmp2/uno;dos;tres"
  local_dir "$BASE_PRACTICAS/PG.LINUSR03_escape/tmp2/uno\"dos\"tres"
  local_dir "$BASE_PRACTICAS/PG.LINUSR03_escape/tmp2/uno\$dos\$tres"
  local_dir "$BASE_PRACTICAS/PG.LINUSR03_escape/tmp2/uno\$PWD"
  local_dir "$BASE_PRACTICAS/PG.LINUSR03_escape/tmp2/uno\\dos\\tres"
}

function EC_LINUSR_gestion_de_directorios() {
  echo -ne "== EC.LINUSR Gestion de Directorios\n"
  local_dir "$BASE_PRACTICAS/EC_LINUSR_directorios/p1/imagenes"
  local_dir "$BASE_PRACTICAS/EC_LINUSR_directorios/p1/documentos"
  local_dir "$BASE_PRACTICAS/EC_LINUSR_directorios/p1/html/publico"
  local_dir "$BASE_PRACTICAS/EC_LINUSR_directorios/p2/imagenes"
  local_dir "$BASE_PRACTICAS/EC_LINUSR_directorios/p2/documentos"
  local_dir "$BASE_PRACTICAS/EC_LINUSR_directorios/p2/html/publico"
  local_dir "$BASE_PRACTICAS/EC_LINUSR_directorios/p3/imagenes"
  local_dir "$BASE_PRACTICAS/EC_LINUSR_directorios/p3/documentos"
  local_dir "$BASE_PRACTICAS/EC_LINUSR_directorios/p3/html/publico"
  return
}

function EC_LINUSR_gestion_de_ficheros() {
  echo -ne "== EC.LINUSR Gestion de ficheros\n"
  return
}

function P_LINUSR_ficheros_y_directorios() {
  local BASE=/home/usuario/ISO/P.LINUSR-1-resuelta

  echo " 4096 drwxrwxr-x
bin 4096 drwxrwxr-x
bin/extractFrames.sh 319 -rwxr-xr-x
bin/ftp-auto.csh 2098 -rw-r--r--
bin/jpegGetDate.sh 63 -rwxr-xr-x
bin/jpegGetEXIFF.sh 48 -rw-r--r--
bin/jpegRotate.sh 926 -rwxr-xr-x
bin/programaX51 109408 -r--r--r--
documentos 4096 drwxrwxr-x
documentos/pdfs 4096 drwxrwxr-x
documentos/pdfs/adm1-en-manual.pdf 1239101 -rw-r--r--
documentos/pdfs/adm2-en-manual.pdf 1280143 -rw-r--r--
documentos/pdfs/grd1-en-manual.pdf 1457897 -rw-r--r--
documentos/pdfs/grd2-en-manual.pdf 1021075 -rw-r--r--
documentos/texto 4096 drwxrwxr-x
documentos/texto/dragon1.txt 755 -rw-r--r--
documentos/texto/dragon2.txt 647 -rw-r--r--
documentos/texto/dragon3.txt 246 -rw-r--r--
documentos/texto/lorem02.txt 12819 -rw-r--r--
imagenes 4096 drwxrwxr-x
imagenes/bamboo2med.gif 19036 -rw-r--r--
imagenes/icon_dilbert.gif 2653 -rw-------
imagenes/Minion-color.jpg 43293 -rw-r--r--
imagenes/Minion-color.png 349599 -rw-r--r--
imagenes/no_brain.jpg 17848 -rw-r--r--
imagenes/oogway.jpg 312386 -rw-r--r--
imagenes/tux-jedi.jpg 10971 -rw-r--r--
web 4096 drwxrwxr-x
web/css 4096 drwxrwxr-x
web/css/gris.css 918 -rw-r--r--
web/html 4096 drwxrwxr-x
web/html/index.html 1611 -rw-r--r--
web/html/listas.html 1201 -rw-r--r--
web/html/tablas.html 1389 -rw-r--r--
web/img 4096 drwxrwxr-x
web/img/root.png 45179 -rw-r--r--" >/tmp/P_LINUSR_ficheros_y_directorios_OK.txt

  find "${BASE}"/ -printf "%P %s %M\n" | grep -v 'web-nueva [34] lrwxrwxrwx' | sort >/tmp/P_LINUSR_ficheros_y_directorios.txt
  if diff -q /tmp/P_LINUSR_ficheros_y_directorios_OK.txt /tmp/P_LINUSR_ficheros_y_directorios.txt >/dev/null; then
    echo -ne "TEST: comparando directorio de destino: "
    print_result 0 "Ficheros y Directorios están correctos."
  else
    echo "Hay algun error en ficheros/directorios/enlaces"
    diff --side-by-side --color=always /tmp/P_LINUSR_ficheros_y_directorios_OK.txt /tmp/P_LINUSR_ficheros_y_directorios.txt
  fi

  local_link "${BASE}"/web-nueva
}

echo -ne "= ${BLUE}TESTS LOCALES${NC}\n"

local_mac $MAC
local_hostname $(printf "ubuntu%02d" ${NUM_LISTA[$i]})
local_user ${ID1}
local_internet

PG_LINUSR_escape
EC_LINUSR_gestion_de_directorios
EC_LINUSR_gestion_de_ficheros
P_LINUSR_ficheros_y_directorios
