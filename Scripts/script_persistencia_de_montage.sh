#!/bin/bash

echo "Inicio script montaje persistente"

echo "Creando puntos de montaje"

sudo mkdir -p /var/lib/docker
sudo mkdir -p /work

echo "Agregando entradas en /etc/fstab"

if ! grep -q "vg_datos-lv_docker" /etc/fstab; then
    echo "/dev/mapper/vg_datos-lv_docker /var/lib/docker ext4 defaults 0 0" | sudo tee -a /etc/fstab
fi

if ! grep -q "vg_datos-lv_workareas" /etc/fstab; then
    echo "/dev/mapper/vg_datos-lv_workareas /work ext4 defaults 0 0" | sudo tee -a /etc/fstab
fi

if ! grep -q "vg_temp-lv_swap" /etc/fstab; then
    echo "/dev/mapper/vg_temp-lv_swap none swap defaults 0 0" | sudo tee -a /etc/fstab
fi

echo "Aplicando montajes persistentes"

sudo systemctl daemon-reload
sudo mount -a
sudo swapon /dev/mapper/vg_temp-lv_swap

echo "Validacion"

df -h
lsblk -f

echo "Fin script montaje persistente"