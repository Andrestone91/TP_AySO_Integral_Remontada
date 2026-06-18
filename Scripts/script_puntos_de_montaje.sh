#!/bin/bash

echo "Inicio script LVM"

echo "Validacion inicial"
lsblk -f
sudo fdisk -l

DISCO_5G="/dev/sdc"
DISCO_3G="/dev/sdd"
DISCO_2G="/dev/sde"

PART_5G="/dev/sdc1"
PART_3G="/dev/sdd1"
PART_2G="/dev/sde1"

echo "Creando particion tipo LVM 8e en disco 5G"
sudo fdisk $DISCO_5G << EOF
n
p
1


t
8e
w
EOF

sudo partprobe $DISCO_5G

echo "Creando particion tipo LVM 8e en disco 3G"
sudo fdisk $DISCO_3G << EOF
n
p
1


t
8e
w
EOF

sudo partprobe $DISCO_3G

echo "Creando particion tipo LVM 8e en disco 2G"
sudo fdisk $DISCO_2G << EOF
n
p
1


t
8e
w
EOF

sudo partprobe $DISCO_2G

echo "Limpiando metadata de discos virtuales"
sudo wipefs -a $PART_5G
sudo wipefs -a $PART_3G
sudo wipefs -a $PART_2G

echo "Creando Physical Volumes"
sudo pvcreate $PART_5G
sudo pvcreate $PART_3G
sudo pvcreate $PART_2G

echo "Creando Volume Groups"
sudo vgcreate vg_datos $PART_5G $PART_2G
sudo vgcreate vg_temp $PART_3G

echo "Creando Logical Volumes"
sudo lvcreate -L 10M -n lv_docker vg_datos
sudo lvcreate -L 2.5G -n lv_workareas vg_datos
sudo lvcreate -L 2.5G -n lv_swap vg_temp

echo "Creando File Systems"
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_docker
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_workareas
sudo mkswap /dev/mapper/vg_temp-lv_swap

echo "Creando puntos de montaje"
sudo mkdir -p /var/lib/docker
sudo mkdir -p /work

echo "Montando normalmente"
sudo mount /dev/mapper/vg_datos-lv_docker /var/lib/docker
sudo mount /dev/mapper/vg_datos-lv_workareas /work
sudo swapon /dev/mapper/vg_temp-lv_swap

sudo systemctl daemon-reload
sudo mount -a

echo "Validacion final"
lsblk -f
sudo pvs
sudo vgs
sudo lvs
df -h

echo "Fin script LVM"