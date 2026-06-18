#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Ejecutar como root"
  exit 1
fi

HOSTNAME_NUEVO="$1"

if [ -z "$HOSTNAME_NUEVO" ]; then
  echo "Uso: ./script_hostname.sh NOMBRE_HOST"
  exit 1
fi

hostnamectl set-hostname "$HOSTNAME_NUEVO"

echo "Hostname configurado como: $HOSTNAME_NUEVO"