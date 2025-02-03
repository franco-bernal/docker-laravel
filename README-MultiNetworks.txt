------------------------------------------------------------
README-MultiNetworks.txt
------------------------------------------------------------
INTRODUCCIÓN:
Este tutorial muestra cómo configurar Docker Compose para utilizar múltiples redes externas:
  - Una red (webnet) para el tráfico web, compartida por Traefik y todas las aplicaciones.
  - Redes separadas para bases de datos (dbnet1 y dbnet2), permitiendo asignar qué aplicaciones
    se conectan a cada instancia de MySQL.
Ejemplo:
  - Prestashop y Laravel se conectan a MySQL en dbnet1.
  - Una aplicación Go se conecta a MySQL en dbnet2.

PASOS Y COMANDOS:

1. Crear las redes externas:
------------------------------------------------------------
docker network create webnet
docker network create dbnet1
docker network create dbnet2
------------------------------------------------------------

2. Configurar Traefik para usar la red webnet:
------------------------------------------------------------
services:
  traefik:
    image: traefik:v2.9
    container_name: traefik_proxy
    networks:
      - webnet
    [otras configuraciones...]
------------------------------------------------------------

3. Configurar las aplicaciones web:

   a) Para Prestashop (y Laravel) usando MySQL en dbnet1:
------------------------------------------------------------
services:
  prestashop_app:
    image: prestashop/prestashop:8.2
    container_name: prestashop_app
    networks:
      - webnet
      - dbnet1
    environment:
      DB_SERVER: mysql1
      DB_NAME: prestashop
      DB_USER: laravel
      DB_PASS: secret
    [otras configuraciones...]
------------------------------------------------------------

   b) Para una aplicación Go usando MySQL en dbnet2:
------------------------------------------------------------
services:
  go_app:
    image: your_go_image
    container_name: go_app
    networks:
      - webnet
      - dbnet2
    environment:
      DB_SERVER: mysql2
      DB_NAME: go_db
      DB_USER: go_user
      DB_PASS: secret
    [otras configuraciones...]
------------------------------------------------------------

4. Configurar las bases de datos:

   a) MySQL para Prestashop/Laravel (dbnet1):
------------------------------------------------------------
services:
  mysql1:
    image: mysql:8.0
    container_name: mysql1
    networks:
      - dbnet1
    environment:
      MYSQL_ROOT_PASSWORD: secret
      MYSQL_DATABASE: prestashop      # (o laravel, según convenga)
      MYSQL_USER: laravel
      MYSQL_PASSWORD: secret
    [otras configuraciones...]
------------------------------------------------------------

   b) MySQL para la aplicación Go (dbnet2):
------------------------------------------------------------
services:
  mysql2:
    image: mysql:8.0
    container_name: mysql2
    networks:
      - dbnet2
    environment:
      MYSQL_ROOT_PASSWORD: secret
      MYSQL_DATABASE: go_db
      MYSQL_USER: go_user
      MYSQL_PASSWORD: secret
    [otras configuraciones...]
------------------------------------------------------------

5. Verificar la configuración de las redes:
------------------------------------------------------------
docker network inspect webnet
docker network inspect dbnet1
docker network inspect dbnet2
------------------------------------------------------------

NOTA:
- Puedes usar cualquier nombre para las redes; en este ejemplo se usan "webnet", "dbnet1" y "dbnet2".
- Asegúrate de que cada archivo docker-compose.yml incluya la declaración de las redes como externas, por ejemplo:
  
  networks:
    webnet:
      external: true
    dbnet1:
      external: true
    dbnet2:
      external: true

------------------------------------------------------------
FIN DEL TUTORIAL: CONFIGURACIÓN DE REDES MÚLTIPLES EN DOCKER COMPOSE
------------------------------------------------------------

