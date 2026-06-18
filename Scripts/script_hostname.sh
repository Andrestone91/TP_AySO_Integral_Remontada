#!/bin/bash

echo "Agregando nombres de VM en /etc/hosts"

if ! grep -q "VM1-Testing" /etc/hosts; then
    echo "192.168.56.10 VM1-Testing" | sudo tee -a /etc/hosts
fi

if ! grep -q "VM2-Produccion" /etc/hosts; then
    echo "192.168.56.11 VM2-Produccion" | sudo tee -a /etc/hosts
fi

echo "Contenido actual de /etc/hosts:"
cat /etc/hosts