-----

## Comprendiendo Tar y Rsync para Copias de Seguridad

Antes de sumergirnos en los ejercicios prácticos, es fundamental entender las herramientas que utilizaremos para nuestras copias de seguridad: **tar** y **rsync**.

### ¿Qué es Tar?

**Tar** (Tape ARchiver) es una utilidad de línea de comandos ampliamente utilizada en sistemas Unix y Linux para crear y manipular archivos comprimidos, comúnmente conocidos como "tarballs" o "archivos tar". Aunque su nombre sugiere "cinta de archivo", tar no se limita solo a cintas; puede archivar archivos y directorios en cualquier medio de almacenamiento.

**Características clave de Tar:**

  * **Archivo:** Permite agrupar múltiples archivos y directorios en un solo archivo, lo que facilita su transporte y almacenamiento.
  * **Compresión:** A menudo se usa en combinación con herramientas de compresión como `gzip`, `bzip2` o `xz` para reducir el tamaño del archivo resultante.
  * **Modos de operación:** Puede crear, extraer, listar y actualizar archivos.
  * **Copias incrementales:** Tar ofrece la capacidad de realizar copias de seguridad incrementales, lo que significa que solo se guardan los archivos que han cambiado desde la última copia de seguridad completa o incremental.

### ¿Qué es Rsync?

**Rsync** (remote synchronization) es una utilidad de línea de comandos para la sincronización y transferencia eficiente de archivos. Es especialmente útil para copiar archivos de forma incremental, tanto localmente como entre sistemas remotos. La característica más distintiva de rsync es su algoritmo diferencial, que detecta y transfiere solo las partes de los archivos que han cambiado, lo que lo hace muy eficiente para actualizaciones y copias de seguridad.

**Características clave de Rsync:**

  * **Sincronización incremental:** Solo copia los cambios, lo que reduce significativamente el tiempo y el ancho de banda necesarios para las transferencias.
  * **Transferencia remota:** Puede copiar archivos a través de la red utilizando SSH para una conexión segura.
  * **Preservación de atributos:** Mantiene los permisos, propietarios, grupos y fechas de modificación de los archivos.
  * **Sincronización bidireccional:** Aunque es más común para la copia de origen a destino, puede sincronizar en ambas direcciones.
  * **Exclusión de archivos:** Permite especificar patrones para excluir ciertos archivos o directorios de la copia.

-----

## Ejercicio de Copia de Seguridad con Tar (Local e Incremental)

En este ejercicio, realizaremos copias de seguridad incrementales del directorio `/data` en tu máquina **Rocky 9.5** (hostname: **rocky**) utilizando `tar`. Las copias se guardarán en el directorio `/backup`.

### Configuración Inicial en Rocky 9.5

Asegúrate de que el directorio `/data` exista y contenga algunos archivos para probar la copia de seguridad. Si no existe, puedes crearlo y añadir algunos archivos de ejemplo:


# En el equipo 'rocky'
sudo mkdir -p /data
echo "Este es el archivo 1 de prueba." | sudo tee /data/file1.txt
echo "Este es el archivo 2 de prueba." | sudo tee /data/file2.txt
sudo mkdir -p /data/subdir
echo "Este es un archivo en un subdirectorio." | sudo tee /data/subdir/subfile.txt
sudo mkdir -p /backup
```

### Paso 1: Copia de Seguridad Completa (Full Backup)

La primera vez que realicemos una copia de seguridad, será una copia completa de todos los archivos. Necesitamos un archivo de "snapshot" para tar, que contendrá información sobre la última copia de seguridad completa para futuras copias incrementales.


# En el equipo 'rocky'
tar -cvpf /backup/full_backup_$(date +%Y%m%d).tar --listed-incremental=/backup/data_snapshot.snar /data/
```

**Explicación del comando:**

  * `tar`: El comando para archivar.
  * `-c`: Crear un nuevo archivo.
  * `-v`: Mostrar el progreso detallado (verbose).
  * `-p`: Preservar permisos.
  * `-f /backup/full_backup_$(date +%Y%m%d).tar`: Especifica el nombre del archivo de salida. `$(date +%Y%m%d)` añade la fecha actual al nombre del archivo para facilitar la identificación.
  * `--listed-incremental=/backup/data_snapshot.snar`: Habilita el modo incremental y especifica el archivo de "snapshot" (`.snar`). Este archivo es crucial para que tar sepa qué archivos han cambiado.
  * `/data/`: El directorio de origen que se va a archivar.

Verifica que el archivo `full_backup_YYYYMMDD.tar` y `data_snapshot.snar` se hayan creado en `/backup`.

### Paso 2: Realizar Cambios en los Datos

Para probar la copia incremental, hagamos algunos cambios en el directorio `/data`.


# En el equipo 'rocky'
echo "Contenido nuevo para file1." | sudo tee /data/file1.txt
echo "Este es un nuevo archivo." | sudo tee /data/new_file.txt
sudo rm /data/file2.txt # Eliminamos un archivo
```

### Paso 3: Copia de Seguridad Incremental

Ahora, realiza la copia de seguridad incremental. Utilizaremos el mismo archivo de snapshot (`data_snapshot.snar`) que creamos en el paso 1.


# En el equipo 'rocky'
tar -cvpf /backup/incremental_backup_$(date +%Y%m%d_%H%M%S).tar --listed-incremental=/backup/data_snapshot.snar /data/
```

**Observaciones:**

  * El comando es casi idéntico al de la copia completa. La clave es el uso continuo del mismo archivo `--listed-incremental=/backup/data_snapshot.snar`.
  * Tar utilizará el archivo `data_snapshot.snar` para determinar qué archivos han sido modificados o añadidos desde la última copia de seguridad (completa o incremental) y solo incluirá esos cambios en el nuevo archivo incremental.
  * El archivo `.snar` se actualiza con la información de la última copia de seguridad realizada.

Verifica que un nuevo archivo `incremental_backup_YYYYMMDD_HHMMSS.tar` se haya creado en `/backup`. Debería ser mucho más pequeño que el archivo de copia de seguridad completo, ya que solo contiene los cambios.

### Restauración (Opcional)

Para restaurar una copia de seguridad incremental, primero necesitarías restaurar la última copia de seguridad completa, y luego aplicar las copias incrementales en orden cronológico.


# Ejemplo de restauración (no ejecutar sin precaución)
# sudo tar -xvpf /backup/full_backup_YYYYMMDD.tar -C /path/to/restore/
# sudo tar -xvpf /backup/incremental_backup_YYYYMMDD_HHMMSS.tar -C /path/to/restore/
```

-----

## Ejercicio de Copia de Seguridad con Rsync (Remoto e Incremental)

En este ejercicio, realizaremos una copia de seguridad remota e incremental del directorio `/data` de **Rocky 9.5** (hostname: **rocky**) al equipo **Ubuntu 24.04** (hostname: **ubuntu**) utilizando `rsync` sobre SSH.

### Configuración Previa

#### En Ambos Equipos (Rocky y Ubuntu)

Asegúrate de que ambos equipos puedan comunicarse entre sí a través de SSH. Si no tienes SSH configurado, instala `openssh-server` en ambos:


# En ambos equipos (rocky y ubuntu)
sudo apt update # Solo en Ubuntu
sudo apt install openssh-server -y # En Ubuntu
sudo dnf install openssh-server -y # En Rocky
sudo systemctl enable sshd --now
```

#### En el Equipo 'rocky'

Asegúrate de que el directorio `/data` exista y contenga los datos que quieres copiar. (Ya lo hicimos en la sección anterior).

#### En el Equipo 'ubuntu'

Crea el directorio donde se guardarán las copias de seguridad.


# En el equipo 'ubuntu'
sudo mkdir -p /backup_from_rocky
sudo chown $USER:$USER /backup_from_rocky # Asegúrate de que tu usuario tenga permisos
```

#### Intercambio de Claves SSH (Recomendado para Automatización)

Para que rsync se ejecute sin pedir contraseña, es altamente recomendable configurar la autenticación por clave SSH.

**Desde el equipo 'rocky':**

1.  Genera un par de claves SSH (si no lo tienes ya):

    
    ssh-keygen
    ```

    Presiona Enter para todas las opciones para usar la ubicación y passphrase por defecto (o deja la passphrase vacía si es para un script automatizado y entiendes los riesgos).

2.  Copia tu clave pública al equipo `ubuntu`:

    
    ssh-copy-id curso@ubuntu
    ```

    Reemplaza `username` con tu nombre de usuario en el equipo Ubuntu y `ubuntu_ip_address` con la dirección IP de Ubuntu. Se te pedirá la contraseña de tu usuario en Ubuntu por última vez.

Ahora, deberías poder conectarte de `rocky` a `ubuntu` vía SSH sin contraseña.

### Paso 1: Primera Copia de Seguridad (Completa)

Realiza la primera copia de seguridad de `/data` de `rocky` a `/backup_from_rocky` en `ubuntu`.


# En el equipo 'rocky'
rsync -avz --delete /data/ curso@ubuntu:/backup/
```

**Explicación del comando:**

  * `rsync`: El comando rsync.
  * `-a`: Modo archivo. Esto es un atajo para `-rlptgoD`, lo que significa:
      * `-r`: Recursivo (copia directorios y su contenido).
      * `-l`: Copia enlaces simbólicos como enlaces simbólicos.
      * `-p`: Preserva permisos.
      * `-t`: Preserva tiempos de modificación.
      * `-g`: Preserva grupo.
      * `-o`: Preserva propietario (requiere que el usuario tenga los mismos UID/GID o sea root en ambos lados).
      * `-D`: Preserva archivos de dispositivo y archivos especiales.
  * `-v`: Modo detallado (verbose), muestra los archivos que se transfieren.
  * `-z`: Comprime los datos durante la transferencia para reducir el uso de ancho de banda.
  * `--delete`: Borra archivos en el destino que no existen en el origen. **¡Usa con precaución\!** Esto asegura que el destino sea una réplica exacta del origen. Si borras un archivo en el origen, también se borrará en el destino en la próxima sincronización. Si no quieres esto, omite esta opción.
  * `/data/`: El directorio de origen en `rocky`. La barra final (`/`) es importante; indica que se copiará el *contenido* de `/data`, no el propio directorio `/data` dentro de `/backup_from_rocky`.
  * `curso@ubuntu:/backup/`: El destino remoto. `curso` es tu usuario en `ubuntu`, `ubuntu` es la IP de Ubuntu, y `/backup/` es el directorio de destino.

Verifica en el equipo `ubuntu` que el contenido de `/data` de `rocky` se ha copiado a `/backup`.


# En el equipo 'ubuntu'
ls -la /backup/
```

### Paso 2: Realizar Cambios en los Datos

Para probar la copia incremental con rsync, hagamos algunos cambios en el directorio `/data` en `rocky`.


# En el equipo 'rocky'
echo "Este es un cambio para file1 en rocky." | sudo tee /data/file1.txt
echo "Otro archivo nuevo." | sudo tee /data/another_new_file.txt
sudo rm /data/subdir/subfile.txt # Eliminamos un archivo
```

### Paso 3: Copia de Seguridad Incremental

Ahora, ejecuta el mismo comando `rsync` de nuevo. Rsync detectará los cambios y solo transferirá las partes modificadas o los archivos nuevos/eliminados.


# En el equipo 'rocky'
rsync -avz --delete /data/ curso@ubuntu:/backup/
```

**Observaciones:**

  * Cuando ejecutes este comando, verás que rsync solo lista los archivos que han cambiado, son nuevos o han sido eliminados.
  * La eficiencia de rsync radica en su algoritmo diferencial, que compara los archivos en origen y destino y solo envía los bloques de datos que son diferentes, lo que minimiza la cantidad de datos transferidos.

Verifica en el equipo `ubuntu` que los cambios se han replicado: `file1.txt` actualizado, `another_new_file.txt` nuevo y `subfile.txt` eliminado.

-----

