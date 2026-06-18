#!/bin/bash

USUARIO="vagrant"
HOME_USUARIO="/home/$USUARIO"
SSH_DIR="$HOME_USUARIO/.ssh"
KNOWN_HOSTS="$SSH_DIR/known_hosts"

if [ "$EUID" -ne 0 ]; then
  echo "Ejecutar como root"
  exit 1
fi

HOSTS=("vm1" "vm2" "192.168.56.10" "192.168.56.11")

mkdir -p "$SSH_DIR"
touch "$KNOWN_HOSTS"

for HOST in "${HOSTS[@]}"; do
  echo "Agregando $HOST a known_hosts..."

  if ssh-keygen -F "$HOST" -f "$KNOWN_HOSTS" > /dev/null; then
    echo "$HOST ya existe en known_hosts."
  else
    ssh-keyscan -H "$HOST" >> "$KNOWN_HOSTS" 2>/dev/null
  fi
done

chown -R "$USUARIO:$USUARIO" "$SSH_DIR"
chmod 700 "$SSH_DIR"
chmod 644 "$KNOWN_HOSTS"

echo "known_hosts configurado."