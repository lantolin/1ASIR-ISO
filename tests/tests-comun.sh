#!/bin/bash

# Colores
B_RED='\033[1;91m'
NC='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'

function print_result() {
  RESULTADO=$1
  TEXTO=""

  if [[ "$2" != "" ]]; then
    TEXTO=" [$2]"
  fi

  if [[ $1 -eq 0 ]]; then
    echo -ne "[${GREEN}OK${NC}]${TEXTO}\n"
  else
    echo -ne "[${RED}ERROR${NC}]${TEXTO}\n"
  fi
  return $1
}

function test_ping() {
  local IP=$1
  ping -c 1 -w 2 ${IP} >/dev/null
  return
}

# Autoriza las claves del nombre de usuario que se le pasa
# Para funcionar necesita que el usuario este creado y tenga password changeme
function autorizar_claves() {
  local usuario=$1
  echo -ne "AUTORIZANDO SSH-${usuario} "
  authorizeSshKeyOnRemoteHost ${usuario}@${IP1_A[$i]} changeme
  RETORNO=$?
  if [[ $RETORNO -ne 0 ]]; then
    echo -ne "[ERROR]\n"
    return 1
  else
    echo -ne "[OK] "
    return 0
  fi
}

# falta otra que auto-comprobar que el hostname es ID1
# argumento1: el usuario
# argumento2: la IP
function sshHostname() {
  local USUARIO=$1
  local IP=$2

  local NAME=""
  echo -ne "TEST: ssh://${USUARIO}@${IP}/ hostname\t"
  NAME=$(ssh -A -oStrictHostKeyChecking=no -o PreferredAuthentications=publickey ${USUARIO}@${IP} hostname)

  RESULTADO=$?
  print_result $RESULTADO $NAME
  return $RESULTADO
}

function sshHome() {
  local USUARIO=$1
  local IP=$2

  local NAME=""
  echo -ne "TEST: ssh://${USUARIO}@${IP}/ HOME\t"
  NAME=$(ssh -A -oStrictHostKeyChecking=no -o PreferredAuthentications=publickey ${USUARIO}@${IP} pwd)

  RESULTADO=$?
  print_result $RESULTADO $NAME
  return $RESULTADO
}

function local_mac() {
  local MAC=$1
  local PUERTO=$2

  echo -ne "TEST: MAC [${MAC}]\t\t"
  SALIDA=$(ip link show enp0s3 | grep -w -o '..:..:..:..:..:..' | grep -v 'ff:ff:ff:ff:ff:ff')
  SALIDA="${SALIDA//$'\n'/ }"

  if [[ "${SALIDA}" =~ ${MAC} ]]; then
    RESULTADO=0
    SALIDA=""
  else
    RESULTADO=1
  fi

  print_result $RESULTADO "$SALIDA"
  return $RESULTADO
}

function local_hostname() {
  local NOMBRE=$1

  echo -ne "TEST: hostname [${NOMBRE}]\t\t"
  SALIDA=$(hostname)

  if [[ "${SALIDA}" == "${NOMBRE}" ]]; then
    RESULTADO=0
    SALIDA=""
  else
    RESULTADO=1
  fi

  print_result $RESULTADO "$SALIDA"
  return $RESULTADO
}

function local_dir() {
  local DIR=$1
  echo -ne "TEST: directorio ["
  echo -n "${DIR}" # para que imprima el nombre de directorio sin interpretar los \x
  echo -ne "]\t"

  test -d "${DIR}"

  RESULTADO=$?
  print_result $RESULTADO
  return $RESULTADO
}

function local_file() {
  local F=$1
  echo -ne "TEST: fichero [${F}]\t"

  test -f "${F}"

  RESULTADO=$?
  print_result $RESULTADO
  return $RESULTADO
}

function local_link() {
  local F=$1
  echo -ne "TEST: link [${F}]\t"

  test -L "${F}"

  RESULTADO=$?
  print_result $RESULTADO
  return $RESULTADO
}

function local_user_with_root() {
  local USUARIO=$1
  echo -ne "TEST: usuario [${USUARIO}]\t\t"
  su ${USUARIO} -c hostname >/dev/null 2>&1

  RESULTADO=$?
  print_result $RESULTADO
  return $RESULTADO
}

function local_user() {
  local USUARIO=$1
  echo -ne "TEST: usuario [${USUARIO}]\t\t"

  SALIDA=$(getent passwd ${USUARIO} 2>/dev/null | cut -d : -f 6)

  RESULTADO=$?
  print_result $RESULTADO "$SALIDA"
  return $RESULTADO
}
function local_internet() {
  echo -ne "TEST: internet (google.com)\t\t"
  wget -q --spider http://google.com

  RESULTADO=$?
  print_result $RESULTADO
  return $RESULTADO
}

function http_puerto_url_texto() {
  local IP=$1
  local PUERTO=$2
  local URL=$3
  local TEXTO="$4"

  echo -ne "TEST: http://${IP}:${PUERTO}${URL} [${TEXTO}]\t"
  SALIDA=$(curl --silent http://${IP}:${PUERTO}"${URL}" -o - | grep "${TEXTO}")
  RESULTADO=$?

  if [[ "${TEXTO}" == "" ]]; then
    SALIDA=""
  else
    if [[ "${SALIDA}" =~ ${TEXTO} ]]; then
      RESULTADO=0
    else
      RESULTADO=1
    fi
  fi

  print_result $RESULTADO "$SALIDA"
  return $RESULTADO
}

function ftp_user_file() {
  local USUARIO=$1
  local IP=$2
  local FICHERO=$3

  echo -ne "TEST: ftp://${USUARIO}@${IP}/\t"
  curl --silent -o /tmp/${ID1}.txt ftp://${USUARIO}:changeme@${IP}/$FICHERO

  # si quiero enseñar el fichero
  #echo -ne "\n*************************\n"
  #curl --silent  ftp://anonymous:hola@${IP1_A[$i]}/welcome.msg;
  #echo -ne "*************************\n"

  RESULTADO=$?
  print_result $RESULTADO
  return $RESULTADO
}

function P_HTTP_id1enindex() {
  echo -ne "P.HTTP ID1 en index.html\t\t"
  RESULTADO=$(curl --silent http://${IP1_A[$i]}/ -o)
  if [[ $RESULTADO =~ /${ID1_A[$i]}/ ]]; then
    echo -ne "[ERROR]\n"
  else
    #echo -ne "[OK]\n"
    echo -ne "[OK] [${RESULTADO}]\n"
  fi
}

function forzar_proxy_apt() {
  local IP=$1
  echo -ne "${YELLOW}Forzando proxy APT${NC}\n"
  scp plantillas/02proxy root@${IP}:/etc/apt/apt.conf.d/02proxy >/dev/null
}

function quitar_proxy_apt() {
  local IP=$1
  echo -ne "${YELLOW}Eliminando proxy APT${NC}\n"
  ssh root@${IP} rm -f /etc/apt/apt.conf.d/02proxy >/dev/null
}
