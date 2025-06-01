---

### Ejercicio 1: Instalación de Docker en Linux Mint Xia  (REVISIÓN)
**Objetivo:** Instalar Docker Engine en Linux Mint Xia siguiendo el procedimiento oficial del fabricante.  

**Pasos:**  
1. Actualizar el índice de paquetes:  
```bash
sudo apt update
```

2. Instalar los paquetes necesarios para permitir que apt use repositorios sobre HTTPS:  
```bash
sudo apt install ca-certificates curl gnupg
```

3. Crear el directorio para las claves GPG:  
```bash
sudo install -m 0755 -d /etc/apt/keyrings
```

4. Descargar la clave GPG oficial de Docker:  
```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

5. Dar permisos de lectura a la clave GPG para el usuario actual:  
```bash
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```

6. Añadir el repositorio de Docker a las fuentes de APT:  
```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu noble stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

> **Nota:** Se ha utilizado el codename `noble`, correspondiente a Ubuntu 24.04, para mantener compatibilidad con Linux Mint basado en esa versión.

7. Actualizar el índice de paquetes nuevamente con el repositorio de Docker añadido:  
```bash
sudo apt update
```

8. Instalar Docker Engine, Docker CLI y Containerd (sin docker-buildx-plugin):  
```bash
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

9. Verificar que el servicio Docker esté activo y funcionando:  
```bash
sudo systemctl status docker
```

10. *(Opcional)* Permitir a un usuario no-root ejecutar comandos Docker:  
- Crear el grupo docker si no existe:  
```bash
sudo groupadd docker
```
- Añadir tu usuario al grupo docker:  
```bash
sudo usermod -aG docker $USER
```
- Cerrar sesión y volver a iniciarla para que los cambios surtan efecto.

--- 


INSTALACIÓN de WEBMIN en docker
docker run -d --name webmin -p 10006:10000 handco/webmin:1.850
