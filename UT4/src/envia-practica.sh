#!/bin/bash

if [[ -z ${1} ]]; then
    echo "Uso: ${0} nombre-de-practica"
    exit 1
fi

PRACTICA="${1}"
NAME=$(dnsdomainname -f)
KEY=$(cut --bytes 25-35 /etc/ssh/ssh_host_ecdsa_key.pub)

if ! curl "http://test.luisantolin.com/entrega?${NAME}&${1}&${KEY}"; then
    echo "ERROR: la entrega no se completo. Comprueba tu conexion a Internet."
    exit 1
fi

exit 0
