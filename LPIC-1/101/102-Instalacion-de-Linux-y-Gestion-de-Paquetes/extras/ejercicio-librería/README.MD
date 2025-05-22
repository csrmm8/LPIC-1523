Guía: Crear y Usar una Librería Compartida en Ubuntu 24.04
🎯 Objetivo
Crear una librería compartida .so en C, compilar un programa que la use y verificar su carga en tiempo de ejecución.

📁 Estructura del Proyecto



mi-libreria/
├── build
│   ├── include
│   └── lib
├── include
│   └── mi_lib.h
├── lib
│   └── mi_funcion.c
└── src
    └── main.c
✅ Paso 1: Instalar herramientas necesarias
Ejecuta:

sudo apt update
sudo apt install build-essential

✅ Paso 2: Crear los archivos
Archivo de cabecera: include/mi_lib.h
Crea el archivo con este contenido:

#ifndef MI_LIB_H
#define MI_LIB_H

void saluda();

#endif

Código de la librería: lib/mi_funcion.c
#include <stdio.h>
#include "mi_lib.h"

void saluda() {
printf("¡Hola desde la librería!\n");
}

Programa principal: src/main.c
#include "mi_lib.h"

int main() {
saluda();
return 0;
}

✅ Paso 3: Compilar el archivo objeto de la librería
gcc -fPIC -Iinclude -c lib/mi_funcion.c -o build/lib/mi_funcion.o

✅ Paso 4: Crear la librería compartida .so
gcc -shared -o build/lib/libmi_lib.so build/lib/mi_funcion.o

✅ Paso 5: Compilar el programa principal
gcc -Iinclude -Lbuild/lib src/main.c -lmi_lib -o build/main

✅ Paso 6: Ejecutar el programa
export LD_LIBRARY_PATH=build/lib:$LD_LIBRARY_PATH
./build/main

Deberías ver:

¡Hola desde la librería!

✅ Paso 7: Verificar si la librería se carga correctamente
ldd ./build/main

Busca una línea similar a:

libmi_lib.so => ./build/lib/libmi_lib.so (0x00007ffff7dd4000)

✅ Paso 8: (Opcional) Limpiar y reconstruir
Para limpiar:

rm build/lib/.o build/lib/ .so build/main

Y repite los pasos desde el 3.

🧰 Resumen Final de Comandos
Compilar objeto
gcc -fPIC -Iinclude -c lib/mi_funcion.c -o build/lib/mi_funcion.o
Crear librería .so
gcc -shared -o build/lib/libmi_lib.so build/lib/mi_funcion.o
Compilar programa
gcc -Iinclude -Lbuild/lib src/main.c -lmi_lib -o build/main
Ejecutar
export LD_LIBRARY_PATH=build/lib:$LD_LIBRARY_PATH && ./build/main
Ver dependencias
ldd ./build/main
