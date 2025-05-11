# Terminal de Windows en Windows 10/11

## ¿Qué es la Terminal de Windows?
La **Terminal de Windows** es una aplicación moderna de línea de comandos que permite a los usuarios ejecutar múltiples entornos de consola en una sola interfaz. Fue diseñada para mejorar la experiencia de terminal en Windows, proporcionando características como pestañas, soporte para múltiples shells y mejor rendimiento.

## Diferencias entre Terminal y CMD
| Característica | CMD (Símbolo del sistema) | Terminal de Windows |
|---------------|-------------------------|--------------------|
| **Interfaz** | Básica, sin pestañas | Moderna, con soporte para pestañas |
| **Compatibilidad** | Solo para comandos de Windows | Compatible con CMD, PowerShell y WSL |
| **Personalización** | Limitada | Temas, transparencia y configuración avanzada |
| **Rendimiento** | Menos optimizado | Mejor rendimiento y aceleración de GPU |

## Futuro de CMD
Microsoft ha mantenido CMD en Windows por compatibilidad con aplicaciones heredadas. Sin embargo, en el futuro, su uso será cada vez más limitado, con Terminal de Windows tomando el protagonismo como herramienta principal para la línea de comandos.

## Instalación de Terminal en Windows 10

### Instalación mediante la Tienda de Microsoft
1. Abre la **Microsoft Store**.
2. Busca `"Windows Terminal"` en la barra de búsqueda.
3. Haz clic en **Instalar**.
4. Espera a que finalice la instalación y ejecútala desde el menú de inicio.

### Instalación mediante comandos en PowerShell
1. Abre **PowerShell** como administrador.
2. Ejecuta el siguiente comando:

    ```powershell
    winget install --id Microsoft.WindowsTerminal -e
    ```

3. Espera a que se complete la instalación y verifica que está disponible ejecutando:

    ```powershell
    wt
    ```

---

¡Espero que esta guía te ayude! 🚀
