#!/bin/bash

# === CONFIGURACIÓN ===
BASH_VERSION="bash-5.2"  # Sin espacios
INSTALL_DIR="/usr/local/bash-minimal"
SOURCE_DIR="/tmp/bash-build"

# === FUNCIONES ÚTILES ===
function check_error() {
    if [ $? -ne 0 ]; then
        echo "❌ Error en paso: $1"
        exit 1
    fi
}

# === PASO 1: Actualizar sistema e instalar dependencias ===
echo "📦 Instalando herramientas necesarias..."
sudo apt update && sudo apt install -y build-essential autoconf automake libtool gettext texinfo
check_error "Instalación de dependencias"

# === PASO 2: Preparar directorios ===
echo "📂 Preparando directorios..."
rm -rf "$SOURCE_DIR"
mkdir -p "$SOURCE_DIR"
cd "$SOURCE_DIR" || { echo "No se puede acceder a $SOURCE_DIR"; exit 1; }

# === PASO 3: Descargar y descomprimir código fuente ===
echo "🌐 Descargando GNU Bash ($BASH_VERSION)..."
wget "https://ftp.gnu.org/gnu/bash/${BASH_VERSION}.tar.gz"
check_error "Descarga del archivo"

tar -xzf "${BASH_VERSION}.tar.gz"
cd "$BASH_VERSION" || { echo "No se puede acceder al directorio de Bash"; exit 1; }

# === PASO 4: Configurar con opciones personalizadas ===
echo "⚙️ Configurando Bash con opciones minimalistas..."

./configure \
    --prefix="$INSTALL_DIR" \
    --enable-static-link \
    --without-bash-malloc \
    --disable-readline \
    --disable-history \
    --disable-alias \
    --disable-job-control \
    --disable-patterns \
    --disable-wordexp \
    --disable-colon-abbreviation \
    --disable-progcomp \
    --disable-promptvars \
    --disable-net-redirections \
    --enable-noclobber
check_error "Configuración"

# === PASO 5: Compilar ===
echo "🧮 Compilando Bash..."
make
check_error "Compilación"

# === PASO 6: Instalar ===
echo "📤 Instalando Bash en $INSTALL_DIR..."
sudo make install
check_error "Instalación"

# === FIN DEL SCRIPT ===
echo "🎉 ¡Bash minimalista instalado correctamente!"
echo "Puedes ejecutarlo con:"
echo "    $INSTALL_DIR/bin/bash"

