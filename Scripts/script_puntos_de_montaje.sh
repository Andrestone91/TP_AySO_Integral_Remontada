#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Ejecutar como root"
  exit 1
fi

mkdir -p /mnt/disco_5g
mkdir -p /mnt/disco_3g
mkdir -p /mnt/disco_2g

echo "Puntos de montaje creados correctamente:"
echo "/mnt/disco_5g"
echo "/mnt/disco_3g"
echo "/mnt/disco_2g"