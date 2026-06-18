#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Ejecutar como root"
  exit 1
fi

HOSTNAME_NUEVO="$1"

if [ -z "$HOSTNAME_NUEVO" ]; then
  echo "Uso: ./index.sh NOMBRE_HOST"
  echo "Ejemplo VM1: ./index.sh vm1"
  echo "Ejemplo VM2: ./index.sh vm2"
  exit 1
fi

bash ./script_hostname.sh "$HOSTNAME_NUEVO"
bash ./script_puntos_de_montaje.sh
bash ./script_persistencia_de_montage.sh
bash ./script_ssh_keygen.sh
bash ./script_ssh_known_hosts.sh

echo ""
echo "Configuración base finalizada."
echo ""
echo "Ahora falta copiar la clave SSH hacia la otra VM."
echo ""
echo "Si estás en VM1, ejecutá:"
echo "sudo ./script_ssh_copy_key.sh vm2"
echo ""
echo "O si no funciona por nombre:"
echo "sudo ./script_ssh_copy_key.sh 192.168.56.11"
echo ""
echo "Si estás en VM2, ejecutá:"
echo "sudo ./script_ssh_copy_key.sh vm1"
echo ""
echo "O si no funciona por nombre:"
echo "sudo ./script_ssh_copy_key.sh 192.168.56.10"
echo ""
echo "Cuando pida contraseña, probá con: vagrant"