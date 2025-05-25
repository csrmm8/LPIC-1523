**Virtualización anidada**

****E**s posible crear una máquina virtual KVM/QEMU dentro de una
máquina virtual de VirtualBox**, pero con **algunas limitaciones**
importantes. Estás entrando en el terreno de la **virtualización
anidada**, y eso depende de:

1.  **Si VirtualBox permite virtualización anidada en tu sistema**.
2.  **Si tu CPU (Intel VT-x o AMD-V) está habilitada y soporta la
    virtualización anidada**.
3.  **Que el sistema host (Windows 10) tenga habilitado VT-x/AMD-V en la
    BIOS/UEFI**.

### ⚠️ Importante:

KVM (Kernel-based Virtual Machine) **requiere acceso directo al hardware
de virtualización**, lo cual normalmente no está disponible dentro de
una VM en VirtualBox **a menos que actives la virtualización anidada**.

## ✅ Requisitos previos

1.  **Sistema host: Windows 10**
2.  **CPU con soporte VT-x (Intel) o AMD-V**
3.  **VirtualBox instalado**
4.  **VirtualBox Guest VM: Ubuntu 24.04 instalada **(Usaremos Linux Mint
    xia)****
5.  **VirtualBox Extension Pack instalado** (en el host)
6.  **VirtualBox VM configurada con virtualización anidada habilitada**

## 🛠 Paso 1: Habilitar virtualización anidada en VirtualBox

1.  **Apaga la VM de Ubuntu 24.04.**

2.  Abre una terminal CMD o PowerShell en Windows.

3.  Ejecuta:

    *VBoxManage modifyvm \"UbuntuVM\" \--nested-hw-virt on*

    Cambia *\"UbuntuVM\"* por el nombre real de tu máquina virtual.

## 🛠 Paso 2: Verificar si KVM está disponible en Ubuntu

1.  Inicia la VM de Ubuntu 24.04.

2.  Abre una terminal y ejecuta:

    *egrep -c \'(vmx\|svm)\' /proc/cpuinfo*

    Si el resultado es **0**, no tienes acceso al hardware de
    virtualización.\
    Si el resultado es **1 o más**, puedes continuar.

3.  Verifica que *kvm* esté disponible:

    *sudo apt update*

    *sudo apt install cpu-checker*

    *kvm-ok*

    Si dice *\"KVM acceleration can be used\"*, ¡estás listo!

## 🛠 Paso 3: Instalar QEMU y herramientas necesarias

*sudo apt install qemu-kvm libvirt-daemon-system libvirt-clients
bridge-utils virt-manager*

Verifica que tu usuario esté en el grupo *libvirt*:

*sudo usermod -aG libvirt \$(whoami)*

*newgrp libvirt*

## 🛠 Paso 4: Crear una VM Alpine con QEMU/KVM

1.  **Descarga Alpine ISO**:

    *wget
    https://dl-cdn.alpinelinux.org/alpine/v3.19/releases/x86_64/alpine-standard-3.19.1-x86_64.iso*

2.  **Crea un disco virtual para Alpine**:

    *qemu-img create -f qcow2 alpine.qcow2 2G*

3.  **Inicia la instalación**:

    *qemu-system-x86_64 \\*

    *-m 512 \\*

    *-enable-kvm \\*

    *-cpu host \\*

    *-drive file=alpine.qcow2,format=qcow2 \\*

    *-cdrom alpine-standard-3.19.1-x86_64.iso \\*

    *-boot d \\*

    *-net nic -net user \\*

    *-nographic*

    Esto inicia la instalación de Alpine en modo consola.

## 📝 Notas adicionales

- Si *-enable-kvm* da error, es que no tienes acceso a KVM. Puedes
  quitarlo y QEMU usará emulación **sin aceleración por hardware**, pero
  será **muy lento**.
- Puedes usar *virt-manager* si prefieres interfaz gráfica: ejecuta
  *virt-manager* y crea la VM desde allí.
- Alpine es ideal por ser liviana, lo cual ayuda cuando estás dentro de
  una VM.

## ✅ Conclusión

Sí, **puedes correr QEMU/KVM dentro de una VM de VirtualBox** si
habilitas **virtualización anidada**. Sin acceso a KVM, QEMU aún puede
funcionar pero más lento. Este tipo de entorno es útil para pruebas,
laboratorios o estudios de virtualización.
