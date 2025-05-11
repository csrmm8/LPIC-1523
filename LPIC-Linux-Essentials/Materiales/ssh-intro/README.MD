# Introducción a SSH: Funcionamiento Básico

## ¿Qué es SSH?
SSH (**Secure Shell**) es un protocolo de comunicación segura que permite la conexión remota a servidores mediante un canal cifrado. Su objetivo principal es proteger la integridad y confidencialidad de los datos transmitidos entre cliente y servidor.

## Uso de pares de claves por parte del servidor
El servidor SSH utiliza un par de claves criptográficas para asegurar las conexiones de los clientes:
- **Clave pública**: Se distribuye y permite que los clientes verifiquen la autenticidad del servidor.
- **Clave privada**: Se almacena de forma segura en el servidor y nunca se comparte.

Cuando un cliente intenta conectarse, el servidor envía su clave pública al cliente, quien la utiliza para validar la autenticidad del servidor antes de establecer la comunicación. Esto previene ataques de suplantación.

## Fingerprint de aceptación
Cada servidor SSH tiene un **fingerprint**, que es una huella digital generada a partir de su clave pública. Cuando un cliente se conecta por primera vez, el servidor le envía esta huella, que se almacena en el archivo `known_hosts` del cliente. Si el fingerprint cambia en una futura conexión (por cambios en la clave del servidor), el cliente recibirá una advertencia para verificar que está conectando al servidor legítimo.

## Esquema de intercambio de claves
SSH utiliza un proceso de **intercambio de claves** para generar una clave de sesión segura:
1. El servidor envía su clave pública al cliente.
2. El cliente valida la autenticidad del servidor utilizando el fingerprint.
3. Se negocia una clave de sesión cifrada mediante algoritmos como **Diffie-Hellman**.
4. A partir de esta clave, se establece un canal seguro, cifrando toda la comunicación posterior.

## Uso de SSH con autenticación por contraseña
Para conectarse a un servidor SSH utilizando autenticación por contraseña, el cliente debe ejecutar:

ssh usuario@servidor


Tras ingresar la contraseña correcta, el servidor validará la autenticación y permitirá el acceso al sistema.

| Opción | Descripción | Ejemplo |
|--------|------------|---------|
| `-p [puerto]` | Especificar un puerto diferente al estándar (22) | `ssh -p 2222 usuario@servidor` |
| `-v` | Activar modo detallado para diagnóstico de conexión | `ssh -v usuario@servidor` |
| `-X` | Habilitar el reenvío de interfaz gráfica | `ssh -X usuario@servidor` |

---

Este documento presenta la funcionalidad básica de SSH, centrándose en el uso de claves por parte del **servidor** y excluyendo otros métodos de autenticación del cliente. 🚀
