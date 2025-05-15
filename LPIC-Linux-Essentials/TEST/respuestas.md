# 📘 Respuestas Linux Essentials - Nivel Medio

## Sección 1: Uso de `man`, `help` y tipos de comandos

### Tipo Test (solo una opción correcta)

1. **✅ Respuesta:** a) `apropos process`  
2. **✅ Respuesta:** b) `history`  
3. **✅ Respuesta:** d) `help exec`  
4. **✅ Respuesta:** c) Que el comando es un alias definido por el usuario  
5. **✅ Respuesta:** c) Muestra la página de manual correspondiente al archivo de configuración `/etc/passwd`  
6. **✅ Respuesta:** b) `echo`  
7. **✅ Respuesta:** d) `-F`  
8. **✅ Respuesta:** c) Una descripción breve de `ls`  
9. **✅ Respuesta:** a) `info`  
10. **✅ Respuesta:** b) `type time`  
11. **✅ Respuesta:** b) Forzar la ejecución de la versión interna de un comando  
12. **✅ Respuesta:** b) Es parte crítica del sistema, disponible incluso en modo mínimo  
13. **✅ Respuesta:** b) `type grep`  
14. **✅ Respuesta:** c) `help tar`  
15. **✅ Respuesta:** a) `-a`

## Sección 2: Movimiento y operaciones básicas

### Tipo Abierto / Escenario / Práctico

16. **✅ Respuesta:** `find /var/log -type f -mtime -7`  
17. **✅ Respuesta:** `cp -rp backup/ destino/`  
18. **✅ Respuesta:** `find ~/ -type f -name "*.log" -exec mv {} logs/ \;`  
19. **✅ Respuesta:** `readlink -f .`  
20. **✅ Respuesta:** `mkdir nueva_carpeta && cd nueva_carpeta`  
21. **✅ Respuesta:** `rm *.tmp`  
22. **✅ Respuesta:** `ls -lhS`  
23. **✅ Respuesta:** `mv informe_final.txt ~/Documentos/archivos_antiguos/informe_viejo.txt`  
24. **✅ Respuesta:** Copia el contenido de `carpeta1` dentro de `carpeta2`.  
25. **✅ Respuesta:** `rmdir temporal/`  
26. **✅ Respuesta:** `mkdir -p proyectos/2025/reportes`  
27. **✅ Respuesta:** `cd -`  
28. **✅ Respuesta:** `ls -1 | wc -l`  
29. **✅ Respuesta:** `mv *.jpg imagenes/`  
30. **✅ Respuesta:** Elimina recursivamente todo lo que haya en el directorio actual sin preguntar.

## Sección 3: Enlaces, permisos, compresión y propietarios

### Tipo Abierto / Escenario / Práctico

31. **✅ Respuesta:** `ln -s /var/www/html/ sitio_web`  
32. **✅ Respuesta:** `chmod 700 config.php`  
33. **✅ Respuesta:** `chown -R desarrollo:devs proyecto/`  
34. **✅ Respuesta:** `tar -cjvf datos.tar.bz2 datos/`  
35. **✅ Respuesta:** `tar -xJvf backup.tar.xz`  
36. **✅ Respuesta:** `ls -l nombre_archivo`  
37. **✅ Respuesta:** `chmod a+x run.sh`  
38. **✅ Respuesta:** `chown -R :staff /home/user/docs/`  
39. **✅ Respuesta:** `ln -s /etc/hosts ~/mi_hosts`  
40. **✅ Respuesta:** `ls -l /home/user/data.txt`
