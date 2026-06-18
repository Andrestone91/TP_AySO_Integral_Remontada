#!/bin/bash

USUARIO="vagrant"
HOME_USUARIO="/home/$USUARIO"
SSH_DIR="$HOME_USUARIO/.ssh"
KEY_FILE="$SSH_DIR/id_rsa"

if [ "$EUID" -ne 0 ]; then
  echo "Ejecutar como root"
  exit 1
fi

mkdir -p "$SSH_DIR"

if [ -f "$KEY_FILE" ]; then
  echo "La clave SSH ya existe. No se genera nuevamente."
else
  echo "Generando clave SSH para $USUARIO..."
  sudo -u "$USUARIO" ssh-keygen -t rsa -b 4096 -f "$KEY_FILE" -N ""
fi

chown -R "$USUARIO:$USUARIO" "$SSH_DIR"
chmod 700 "$SSH_DIR"
chmod 600 "$KEY_FILE"
chmod 644 "$KEY_FILE.pub"

echo "Clave SSH lista."