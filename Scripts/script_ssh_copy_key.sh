#!/bin/bash

USUARIO="vagrant"
HOME_USUARIO="/home/$USUARIO"
PUBLIC_KEY="$HOME_USUARIO/.ssh/id_rsa.pub"

if [ "$EUID" -ne 0 ]; then
  echo "Ejecutar como root"
  exit 1
fi

DESTINO="$1"

if [ -z "$DESTINO" ]; then
  echo "Uso: ./script_ssh_copy_key.sh DESTINO"
  echo "Ejemplo con nombre: ./script_ssh_copy_key.sh vm2"
  echo "Ejemplo con IP: ./script_ssh_copy_key.sh 192.168.56.11"
  exit 1
fi

if [ ! -f "$PUBLIC_KEY" ]; then
  echo "No existe la clave pública. Ejecutá primero script_ssh_keygen.sh"
  exit 1
fi

echo "Copiando clave pública a $DESTINO..."

sudo -u "$USUARIO" ssh-copy-id -o StrictHostKeyChecking=no "$USUARIO@$DESTINO"

echo "Clave copiada a $DESTINO."