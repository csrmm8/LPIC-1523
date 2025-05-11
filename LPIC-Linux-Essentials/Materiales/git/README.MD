# Git y GitHub: Introducción y Configuración de un Repositorio

## ¿Qué es Git?
Git es un sistema de control de versiones distribuido utilizado para gestionar proyectos de software. Permite realizar seguimiento de cambios en el código, colaborar con otros desarrolladores y mantener un historial de versiones.

### ¿Por qué se desarrolló Git?
Git fue creado por Linus Torvalds en 2005 para mejorar el desarrollo del núcleo de Linux. Antes de Git, los desarrolladores usaban sistemas que no cumplían con los requisitos de rendimiento y flexibilidad. Sus principales objetivos incluyen:
- Velocidad y eficiencia en la gestión de versiones.
- Trabajo descentralizado, permitiendo contribuciones desde cualquier lugar.
- Integridad de los datos, asegurando que cada cambio quede registrado correctamente.

## ¿Qué es GitHub?
GitHub es una plataforma de alojamiento de código basada en Git. Permite a los desarrolladores almacenar, compartir y colaborar en proyectos, ofreciendo características como:
- Repositorios públicos y privados.
- Integraciones con herramientas de CI/CD.
- Gestión de problemas y solicitudes de extracción (Pull Requests).

## Instalación de Git

### Git en distribuciones Linux
Muchas distribuciones de Linux incluyen Git por defecto. Para comprobarlo, ejecuta:

git --version

Si Git no está instalado, puedes instalarlo con:
- Debian/Ubuntu: sudo apt install git
- Fedora: sudo dnf install git
- Arch Linux: sudo pacman -S git

### Instalación de Git en Windows
En Windows, puedes instalar Git de la siguiente manera:
1. Descarga el instalador desde [git-scm.com](https://git-scm.com/).
2. Ejecuta el instalador y sigue las instrucciones (opciones predeterminadas son recomendadas).
3. Verifica la instalación ejecutando:

git --version

## Configuración de un repositorio de GitHub

### Paso 1: Configurar Git
1. Abre la terminal y configura tu nombre y correo electrónico:

git config --global user.name "Tu Nombre"
git config --global user.email "tuemail@example.com"

### Paso 2: Crear un repositorio en GitHub
1. Accede a [GitHub](https://github.com) y crea una cuenta (si aún no tienes una).
2. Haz clic en "New Repository".
3. Asigna un nombre y elige las opciones de privacidad.
4. Copia la URL del repositorio recién creado.

### Paso 3: Clonar el repositorio en tu sistema
1. Abre la terminal y ejecuta:

git clone https://github.com/usuario/repositorio.git

2. Accede al directorio del repositorio:

cd repositorio

### Paso 4: Realizar cambios y subirlos a GitHub
1. Crea o modifica un archivo dentro del repositorio.
2. Agrega y confirma los cambios:

git add .
git commit -m "Mensaje de commit"

3. Envía los cambios a GitHub:

git push origin main

---

Con esto ya tienes tu primer repositorio en GitHub configurado y listo para trabajar.
