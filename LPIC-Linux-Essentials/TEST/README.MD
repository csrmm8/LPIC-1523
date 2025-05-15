# 🧠 Preguntas Linux Essentials - Nivel Medio

## Sección 1: Uso de `man`, `help` y tipos de comandos

### Tipo Test (solo una opción correcta)

1. ¿Qué comando puedes usar para buscar comandos relacionados con "procesos" sin salir del terminal?
   - a) `apropos process`
   - b) `man --search process`
   - c) `grep process /etc/man.conf`
   - d) `info process`

2. ¿Cuál de los siguientes comandos es un comando interno del shell bash?
   - a) `ps`
   - b) `history`
   - c) `top`
   - d) `ls`

3. ¿Cómo obtienes ayuda sobre la sintaxis de redirección en el shell actual?
   - a) `man redirection`
   - b) `help redirection`
   - c) `help echo`
   - d) `help exec`

4. ¿Qué indica que `type` devuelva "alias" al consultar un comando?
   - a) Que el comando está deshabilitado
   - b) Que el comando es una palabra clave del shell
   - c) Que el comando es un alias definido por el usuario
   - d) Que el comando no existe

5. ¿Qué hace el comando `man 5 passwd`?
   - a) Muestra información general sobre `passwd`
   - b) Muestra solo errores posibles de `passwd`
   - c) Muestra la página de manual correspondiente al archivo de configuración `/etc/passwd`
   - d) Ejecuta `passwd` en modo seguro

6. ¿Cuál de estos NO es un comando externo?
   - a) `df`
   - b) `echo`
   - c) `ping`
   - d) `who`

7. ¿Qué opción de `man` permite abrir directamente el primer resultado que coincida?
   - a) `-f`
   - b) `-k`
   - c) `-1`
   - d) `-F`

8. ¿Qué muestra el comando `whatis ls`?
   - a) El tipo de `ls`
   - b) La ubicación de `ls`
   - c) Una descripción breve de `ls`
   - d) Los permisos de `ls`

9. ¿Cuál de los siguientes comandos puede mostrar documentación detallada similar a `man`, pero más amigable?
   - a) `info`
   - b) `--help`
   - c) `help`
   - d) `apropos`

10. ¿Cómo verificas si `time` es un comando interno o externo?
    - a) `which time`
    - b) `type time`
    - c) `whereis time`
    - d) `locate time`

11. ¿Para qué sirve el comando `builtin`?
    - a) Ejecutar comandos externos como internos
    - b) Forzar la ejecución de la versión interna de un comando
    - c) Listar todos los comandos disponibles
    - d) Mostrar ayuda extendida de un comando

12. ¿Qué significa que un comando esté en `/bin/`?
    - a) Solo lo usa root
    - b) Es parte crítica del sistema, disponible incluso en modo mínimo
    - c) No tiene documentación
    - d) Es un comando temporal

13. ¿Qué comando usas para saber si `grep` es un alias?
    - a) `alias grep`
    - b) `type grep`
    - c) `which grep`
    - d) `grep --version`

14. ¿Cuál de estos comandos NO puede usarse para buscar ayuda sobre `tar`?
    - a) `man tar`
    - b) `tar --help`
    - c) `help tar`
    - d) `info tar`

15. ¿Qué opción de `man` permite mostrar todas las páginas de un comando que existen en diferentes secciones?
    - a) `-a`
    - b) `-k`
    - c) `-f`
    - d) `-p`

## Sección 2: Movimiento y operaciones básicas

### Tipo Abierto / Escenario / Práctico

16. Escribe el comando para listar los archivos modificados en los últimos 7 días dentro del directorio `/var/log`.

17. ¿Cómo copias recursivamente la carpeta `backup/` manteniendo sus permisos originales?

18. ¿Qué comando usarías para encontrar todos los archivos `.log` en tu home y moverlos a una carpeta llamada `logs/`?

19. Escribe el comando que muestra la ruta absoluta del directorio actual sin usar `pwd`.

20. ¿Cómo creas una carpeta nueva y entras en ella en un solo comando?

21. ¿Qué comando usarías para eliminar archivos terminados en `.tmp` dentro del directorio actual sin pedir confirmación?

22. Escribe el comando que lista los archivos ordenados por tamaño descendente, mostrando detalles.

23. ¿Cómo mueves el archivo `informe_final.txt` a la carpeta `~/Documentos/archivos_antiguos/` y renombras el archivo como `informe_viejo.txt`?

24. ¿Qué sucede si ejecutas `cp -r carpeta1 carpeta2` cuando `carpeta2` ya existe?

25. ¿Cómo borras un directorio vacío llamado `temporal/`?

26. ¿Qué comando usarías para crear una estructura de carpetas anidadas como `proyectos/2025/reportes/` en una sola línea?

27. ¿Cómo cambias al directorio anterior (el último donde estabas)?

28. ¿Qué comando usarías para contar cuántos archivos hay en el directorio actual?

29. ¿Cómo mueves todos los archivos `.jpg` desde el directorio actual a una carpeta llamada `imagenes/`?

30. ¿Qué efecto tiene `rm -rf *` en un directorio?

## Sección 3: Enlaces, permisos, compresión y propietarios

### Tipo Abierto / Escenario / Práctico

31. Escribe el comando para crear un enlace simbólico al directorio `/var/www/html/` llamado `sitio_web`.

32. ¿Cómo das permiso de lectura, escritura y ejecución solo al propietario del archivo `config.php`?

33. ¿Qué comando usarías para cambiar el propietario y grupo de la carpeta `proyecto/` al usuario `desarrollo` y grupo `devs`?

34. ¿Cómo comprimes el directorio `datos/` en formato `.tar.bz2` usando un único comando?

35. ¿Cómo descomprimes el archivo `backup.tar.xz`?

36. ¿Qué comando te muestra los permisos y propietario de un archivo?

37. ¿Cómo das permiso de ejecución a todos los usuarios del script `run.sh`?

38. ¿Cómo cambias recursivamente el grupo propietario de todos los archivos en `/home/user/docs/` al grupo `staff`?

39. ¿Cómo creas un enlace simbólico al archivo `/etc/hosts` dentro de tu home, llamándolo `mi_hosts`?

40. ¿Qué comando usarías para verificar los permisos actuales de `/home/user/data.txt`?
