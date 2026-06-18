#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Ejecutar como root"
  exit 1
fi

DISCO_5G="/dev/sdc"
DISCO_3G="/dev/sdd"
DISCO_2G="/dev/sde"

MNT_5G="/mnt/disco_5g"
MNT_3G="/mnt/disco_3g"
MNT_2G="/mnt/disco_2g"

formatear_si_hace_falta() {
  DISCO=$1

  if blkid "$DISCO" > /dev/null 2>&1; then
    echo "$DISCO ya tiene formato. No se formatea."
  else
    echo "Formateando $DISCO..."
    mkfs.ext4 -F "$DISCO"
  fi
}

agregar_fstab_si_hace_falta() {
  DISCO=$1
  PUNTO_MONTAJE=$2

  UUID_DISCO=$(blkid -s UUID -o value "$DISCO")

  if grep -q "$UUID_DISCO" /etc/fstab; then
    echo "$DISCO ya está en /etc/fstab."
  else
    echo "Agregando $DISCO a /etc/fstab..."
    echo "UUID=$UUID_DISCO $PUNTO_MONTAJE ext4 defaults 0 0" >> /etc/fstab
  fi
}

mkdir -p "$MNT_5G"
mkdir -p "$MNT_3G"
mkdir -p "$MNT_2G"

formatear_si_hace_falta "$DISCO_5G"
formatear_si_hace_falta "$DISCO_3G"
formatear_si_hace_falta "$DISCO_2G"

agregar_fstab_si_hace_falta "$DISCO_5G" "$MNT_5G"
agregar_fstab_si_hace_falta "$DISCO_3G" "$MNT_3G"
agregar_fstab_si_hace_falta "$DISCO_2G" "$MNT_2G"

mount -a

echo "Persistencia de montaje configurada correctamente."