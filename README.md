====================================================
            francobg-project README
====================================================

Este repositorio contiene la configuración para una aplicación Laravel
ejecutándose en Docker, incluyendo:
  - Dockerfile (definición de la imagen PHP + Apache para Laravel)
  - docker-compose.yml (orquesta los servicios: app [Laravel], db [MySQL],
    phpMyAdmin y Traefik [reverse proxy])
  - Código de la aplicación Laravel (ubicado en el subdirectorio "app")
  - Ejemplo de archivo .env (configuración básica de Laravel)

----------------------------------------------------
Requisitos Previos
----------------------------------------------------
1. Tener instalado en el servidor (Ubuntu 22.04 o similar):
   - Docker (versión 27.5.1 o superior)
   - Docker Compose (plugin; ejemplo: versión v2.32.4 o superior)

2. Configurar los registros DNS para tu dominio:
   - "francobg.online" debe apuntar a la IP de tu servidor.
   - (Opcional) "pma.francobg.online" para acceder a phpMyAdmin.

----------------------------------------------------
Instrucciones de Instalación
----------------------------------------------------
1. Clonar el repositorio en el servidor:
   ----------------------------------------------------------------
   # Elige la carpeta donde alojarás el proyecto, por ejemplo:
   sudo mkdir -p /var/www/francobg-project
   cd /var/www/francobg-project

   # Clona el repositorio (reemplaza la URL con la de tu repositorio)
   git clone https://github.com/tu_usuario/francobg-project.git .
   ----------------------------------------------------------------

2. Instalar dependencias de Composer (si la carpeta "vendor" NO está incluida):
   ----------------------------------------------------------------
   docker compose run --rm app composer install
   ----------------------------------------------------------------

3. Configurar el archivo .env:
   - Revisa el archivo .env incluido o créalo en la raíz del proyecto.
   - Asegúrate de que las variables (como DB_*) coincidan con la configuración
     en docker-compose.yml.
   - Genera la clave de la aplicación con:
     ----------------------------------------------------------------
     docker compose exec app php artisan key:generate
     ----------------------------------------------------------------

4. Ajustar permisos en directorios críticos (para evitar errores de escritura):
   ----------------------------------------------------------------
   docker compose exec app chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
   docker compose exec app chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache
   ----------------------------------------------------------------

5. Levantar el entorno Docker:
   ----------------------------------------------------------------
   docker compose up -d --build
   ----------------------------------------------------------------
   Esto reconstruirá y levantará todos los contenedores:
     - "laravel_app" (servicio de la aplicación Laravel)
     - "mysql_db" (base de datos MySQL)
     - "phpmyadmin" (interfaz phpMyAdmin)
     - "traefik_proxy" (reverse proxy con Traefik)

----------------------------------------------------
Verificación y Acceso
----------------------------------------------------
- Para acceder a la aplicación Laravel:
    http://francobg.online
  (y, si configuraste HTTPS, también podrás usar https://francobg.online)

- Para acceder a phpMyAdmin:
    http://pma.francobg.online  (o la URL configurada en tu DNS)

- (Opcional) Para ver el dashboard de Traefik, si lo activaste, accede al puerto indicado.

----------------------------------------------------
Uso y Actualización
----------------------------------------------------
- Para ejecutar comandos de Artisan o Composer en tiempo de ejecución:
  ----------------------------------------------------------------
  docker compose exec app php artisan <comando>
  docker compose exec app composer <comando>
  ----------------------------------------------------------------

- Para actualizar el proyecto tras modificar el código:
  ----------------------------------------------------------------
  git add .
  git commit -m "Descripción de los cambios"
  git push
  ----------------------------------------------------------------
  Y luego, en el servidor, levantar nuevamente con:
  ----------------------------------------------------------------
  docker compose up -d --build
  ----------------------------------------------------------------

----------------------------------------------------
Notas Adicionales
----------------------------------------------------
- La carpeta "vendor" y otros directorios sensibles (como .env) están en el .gitignore.
- Los volúmenes de Docker (por ejemplo, para la base de datos) se gestionan de forma externa;
  si se eliminan, se perderán los datos.
- Para un reinicio completo, se recomienda detener los contenedores con:
  ----------------------------------------------------------------
  docker compose down
  ----------------------------------------------------------------
  Y luego volver a levantar con:
  ----------------------------------------------------------------
  docker compose up -d --build
  ----------------------------------------------------------------

====================================================
          FIN DEL README - francobg-project
====================================================

