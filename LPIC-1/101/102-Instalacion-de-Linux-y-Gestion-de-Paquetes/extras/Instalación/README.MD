# Guía de Instalación de Servidores Linux

Este documento contiene los pasos detallados para la instalación mínima de tres distribuciones Linux servidor:
- Ubuntu Server 24.04.2 LTS
- Rocky Linux 9.5
- openSUSE Leap

⚠️ Nota importante: La contraseña "qwerty" es solo para fines educativos o laboratorio. Nunca uses contraseñas débiles en entornos de producción.

---

## Requisitos Mínimos y Recomendados

| Componente       | Mínimo     | Recomendado |
|------------------|------------|-------------|
| CPU              | 1 núcleo   | 2 núcleos   |
| Memoria RAM      | 1 GB       | 2 GB        |
| Almacenamiento   | 10 GB      | 20 GB       |
| Red              | LAN        | LAN + DHCP  |
| Acceso a Internet| Sí         | Sí          |

Todas las instalaciones se realizarán sin entorno gráfico y con el conjunto mínimo de paquetes desde los repositorios predeterminados.

---

## Ubuntu Server 24.04.2 LTS

### Descarga
[Ubuntu Server 24.04.2](https://releases.ubuntu.com/24.04/ubuntu-24.04.2-live-server-amd64.iso )

### Pasos de Instalación

1. Inserta el medio de instalación (USB/CD/DVD) y arranca desde él.
2. Selecciona **Install Ubuntu Server**.
3. Selecciona el idioma.
4. Selecciona tu ubicación geográfica.
5. Teclado: selecciona el modelo y disposición correctos.
6. Nombre del host: asigna un nombre al servidor.
7. Crea un usuario:
   - Nombre completo: Curso
   - Nombre de usuario: curso
8. Contraseña: qwerty (confirmar).
9. Confirmar si deseas cifrar el sistema de inicio de sesión: No.
10. Zona horaria: selecciona la correcta.
11. Particionado:
    - Selecciona Guided - Use entire disk
    - Confirma particionado.
12. Actualizaciones automáticas: No automatic updates.
13. Software selection:
    - Desmarca todas las opciones.
    - Asegúrate de dejar marcada únicamente SSH server si aparece.
14. Instalar GRUB: Yes.
15. Reinicia el sistema.

### Activar SSH (si no se instaló automáticamente)

Tras iniciar sesión:

Ejecuta este comando:

sudo apt update && sudo apt install -y openssh-server

---

## Rocky Linux 9.5

### Descarga
[Rocky Linux 9.5](https://download.rockylinux.org/pub/rocky/9.5/isos/x86_64/Rocky-9.5-x86_64-dvd1.iso )

### Pasos de Instalación

1. Arranca desde el medio de instalación.
2. Selecciona **Install Rocky Linux 9.5**.
3. Selecciona el idioma y continúa.
4. En "Installation Summary":
   - Date & Time: Configura la zona horaria.
   - Keyboard: Configura el teclado.
   - Network & Host Name: Activa la red y establece un nombre de host.
   - Installation Destination:
     - Selecciona el disco.
     - Usa Automatic o particiona manualmente.
   - Software Selection:
     - Base Environment: Minimal Install
     - No marques ningún grupo adicional.
   - User Creation:
     - Nombre: Curso
     - Nombre de usuario: curso
     - Contraseña: qwerty
     - Marca la opción para hacerlo administrador (opcional).
5. Haz clic en Begin Installation.
6. Una vez terminada la instalación, reinicia.

### Instalar y activar SSH después de la instalación

Tras iniciar sesión:

Ejecuta estos comandos:

sudo dnf install -y openssh-server
sudo systemctl enable sshd --now

---

## openSUSE Leap

### Descarga
[openSUSE Leap](https://download.opensuse.org/distribution/leap/15.6/iso/openSUSE-Leap-15.6-DVD-x86_64.iso )

> Nota: openSUSE Leap 15.6 es la versión más reciente estable equivalente a las demás distribuciones mencionadas.

### Pasos de Instalación

1. Arranca desde el medio de instalación.
2. Selecciona **Installation**.
3. Elige el idioma y pulsa Next.
4. Licencia: acepta los términos y continúa.
5. Tipo de instalación: New Installation.
6. Zona horaria: selecciona la correcta.
7. Software:
   - Selecciona Minimal System.
   - No selecciones ningún otro patrón.
8. Particionado:
   - Selecciona Guided Setup → Next
   - Selecciona el disco y usa Use Entire Disk
9. Crear usuario:
   - Nombre completo: Curso
   - Nombre de usuario: curso
   - Contraseña: qwerty
10. Establece una contraseña de root (o déjala vacía si lo prefieres).
11. Resumen de configuración: revisa y haz clic en Install.
12. Reinicia cuando termine.

### Instalar y activar SSH después de la instalación

Tras iniciar sesión:

Ejecuta estos comandos:

sudo zypper install -y openssh
sudo systemctl enable sshd
sudo systemctl start sshd

---

## Configuración Común Post-Instalación

### Verificar acceso SSH

En todos los sistemas:

Ejecuta este comando para ver la dirección IP:

ip addr show

Desde otra máquina, prueba conectarte con:

ssh curso@<direccion-ip>

Contraseña: qwerty

---

## Resumen Final

| Distribución      | URL de Descarga                              | Entorno Gráfico | Paquete SSH         |
|-------------------|-----------------------------------------------|------------------|----------------------|
| Ubuntu 24.04.2    | [Link](https://releases.ubuntu.com/24.04/ )    | No               | openssh-server       |
| Rocky Linux 9.5   | [Link](https://rockylinux.org/download/ )      | No               | openssh-server       |
| openSUSE Leap     | [Link](https://get.opensuse.org/leap/ )        | No               | openssh              |

---

## Notas Adicionales

- Cambia inmediatamente la contraseña del usuario curso en producción:
  
  passwd

- Considera usar claves SSH en lugar de contraseñas para mayor seguridad.
- Si usas un entorno virtualizado (VirtualBox, VMware, etc.), asegúrate de tener las herramientas de integración instaladas.
