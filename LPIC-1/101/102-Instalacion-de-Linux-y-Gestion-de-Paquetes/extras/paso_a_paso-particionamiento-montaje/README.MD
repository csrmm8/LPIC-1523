# Guía: Agregar Discos NVMe y SATA a una VM en VirtualBox

## 🎯 Objetivo

Agregar dos discos virtuales (NVMe y SATA) de 20 GB a una máquina virtual Linux en VirtualBox, particionarlos con tabla GPT, formatear las particiones con ext4 y XFS, y verificar su uso mediante montaje y escritura.

---

## 🔧 Requisitos

- Máquina virtual Linux funcionando (Ubuntu Server, Rocky, etc.)
- VirtualBox instalado
- Acceso a terminal

---

## ✅ Paso 1: Crear los VDI Virtuales

En la terminal del host (Windows o Linux), ejecutar:

VBoxManage createhd --filename disk_nvme.vdi --size 20480 --format VDI
VBoxManage createhd --filename disk_sata.vdi --size 20480 --format VDI

> Esto crea dos discos virtuales de 20 GB: uno para simular un disco NVMe y otro un disco SATA.

---

## ✅ Paso 2: Adjuntar los Discos a la Máquina Virtual

Reemplaza "NombreVM" por el nombre exacto de tu máquina virtual:

VBoxManage storageattach "NombreVM" --storagectl "NVMe" --port 0 --device 0 --type hdd --medium disk_nvme.vdi
VBoxManage storageattach "NombreVM" --storagectl "SATA" --port 0 --device 0 --type hdd --medium disk_sata.vdi

> Si no tienes controladores llamados "NVMe" o "SATA", puedes crearlos desde la interfaz gráfica de VirtualBox o usar los disponibles por defecto.

---

## ✅ Paso 3: Arrancar la VM e Identificar los Nuevos Discos

Arranca la máquina virtual y accede al sistema.

Ejecuta este comando para listar los dispositivos de bloque:

lsblk

Deberías ver algo similar a:

NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
sda      8:0    0  20G  0 disk
nvme0n1 259:0   0  20G  0 disk

---

## ✅ Paso 4: Particionar con FDISK (Tabla GPT)

### Para el disco NVMe (/dev/nvme0n1):

sudo fdisk /dev/nvme0n1

Dentro del programa fdisk:
- Pulsa g → crear nueva tabla GPT
- Pulsa n → nueva partición 1, aceptar valores por defecto
- Pulsa n → nueva partición 2, aceptar valores por defecto
- Pulsa w → escribir cambios y salir

### Para el disco SATA (/dev/sda):

sudo fdisk /dev/sda

Repite los mismos pasos que arriba.

---

## ✅ Paso 5: Verificar Particiones Creadas

Ejecuta:

lsblk

Salida esperada:

NAME        MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
nvme0n1     259:0   0  20G  0 disk
├─nvme0n1p1 259:1   0  ...     part
└─nvme0n1p2 259:2   0  ...     part
sda         8:0     0  20G  0 disk
├─sda1      8:1     0  ...     part
└─sda2      8:2     0  ...     part

---

## ✅ Paso 6: Formatear Particiones

### Disco NVMe:

sudo mkfs.ext4 /dev/nvme0n1p1
sudo mkfs.xfs /dev/nvme0n1p2

### Disco SATA:

sudo mkfs.ext4 /dev/sda1
sudo mkfs.xfs /dev/sda2

---

## ✅ Paso 7: Montar y Probar las Particiones

### Crear directorios de prueba en /mnt:

sudo mkdir -p /mnt/nvme1 /mnt/nvme2 /mnt/sda1 /mnt/sda2

### Montar las particiones:

sudo mount /dev/nvme0n1p1 /mnt/nvme1
sudo mount /dev/nvme0n1p2 /mnt/nvme2
sudo mount /dev/sda1       /mnt/sda1
sudo mount /dev/sda2       /mnt/sda2

---

## ✅ Paso 8: Prueba de Escritura

Crea archivos de prueba en cada partición:

echo "Prueba en nvme1" > /mnt/nvme1/prueba.txt
echo "Prueba en nvme2" > /mnt/nvme2/prueba.txt
echo "Prueba en sda1"  > /mnt/sda1/prueba.txt
echo "Prueba en sda2"  > /mnt/sda2/prueba.txt

Muestra el contenido para verificar:

cat /mnt/nvme1/prueba.txt
cat /mnt/nvme2/prueba.txt
cat /mnt/sda1/prueba.txt
cat /mnt/sda2/prueba.txt

---

## ✅ Paso 9: Desmontar las Particiones

Desmonta todas las particiones cuando termines:

sudo umount /mnt/nvme1
sudo umount /mnt/nvme2
sudo umount /mnt/sda1
sudo umount /mnt/sda2

Puedes eliminar los directorios si ya no los necesitas:

sudo rmdir /mnt/nvme1 /mnt/nvme2 /mnt/sda1 /mnt/sda2

---

## ✅ Resumen Final

| Acción             | Comando Ejemplo                          |
|--------------------|------------------------------------------|
| Listar discos      | lsblk                                    |
| Particionar        | sudo fdisk /dev/nvme0n1                  |
| Formatear ext4     | sudo mkfs.ext4 /dev/nvme0n1p1            |
| Formatear xfs      | sudo mkfs.xfs /dev/nvme0n1p2             |
| Montar             | sudo mount /dev/nvme0n1p1 /mnt/nvme1     |
| Desmontar          | sudo umount /mnt/nvme1                   |

---

## 📝 Notas Adicionales

- Estos pasos también pueden aplicarse en entornos reales (no virtuales).
- Usa siempre herramientas de diagnóstico como `dmesg` o `partprobe` si el sistema no reconoce inmediatamente los nuevos discos.
- En producción, evita usar `/mnt` permanentemente; usa puntos de montaje personalizados (ej: `/data`, `/backup`, etc.)
