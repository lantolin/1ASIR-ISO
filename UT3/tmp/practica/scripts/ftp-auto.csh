#!/bin/bash 
################################################################################
# autoftp - automates FTP transfers.                                           #
#                                                                              #
# USE: autoftp <machine> <user> <password> <local_file> <remote_file>          #
#                                                                              #
#                                                        by: Luis Antolin Cano #
################################################################################

if [[ ($# -eq 0) ]]; then
  printf "USE: $0:t --host <machine> [--port <port>] --user <user> --password <password> --command <get|put> --source <source_file> [--passive] [--dest <dest_file>]\n"
  exit
fi

# Get command line arguments
while [ "${1}" != "" ]; do
  opt=${1}
  shift

  if [ "${opt}" = "--passive" ] ; then
    PASSIVE=passive
  fi

  if [ "${opt}" = "--host" ] ; then
    HOST=${1}
    shift
  fi

  if [ "${opt}" = "--port" ] ; then
    PORT=${1}
    shift
  fi

  if [ "${opt}" = "--user" ] ; then
    USER=${1}
    shift
  fi

  if [ "${opt}" = "--password" ] ; then
    PASSWORD=${1}
    shift
  fi

  if [ "${opt}" = "--command" ] ; then
    COMMAND=${1}
    shift
  fi

  if [ "${opt}" = "--source" ] ; then
    SOURCE=${1}
    shift
  fi

  if [ "${opt}" = "--dest" ] ; then
    DEST=${1}
    shift
  fi

done

# Comprobar que los obligatorios estan y poner defaults en los optativos si no estan

if [ "${HOST}" = "" -o "${USER}" = "" -o "${PASSWORD}" = "" -o "${COMMAND}" = "" -o "${SOURCE}" = "" ]; then
  printf "USE: $0:t --host <machine> [--port <port>] --user <user> --password <password> --command <get|put> --source <source_file> [--dest <dest_file>]\n"
  exit
fi

if [ "${PORT}" = "" ]; then
  PORT=21;
fi

if [ "${DEST}" = "" ]; then
  DEST=${SOURCE};
fi

# Y a ello.

/usr/bin/ftp -n << EOF 
open ${HOST} ${PORT}
user ${USER} ${PASSWORD}
${PASSIVE}
hash
bin
${COMMAND} ${SOURCE} ${DEST}
close
EOF

