------------------------------------------------------------
README-ExternalNetwork.txt
------------------------------------------------------------
INTRODUCCIÓN:
Utilizar una red externa en Docker Compose permite que contenedores de distintos proyectos (por ejemplo, Prestashop y Laravel) se comuniquen entre sí. Esto es especialmente útil para compartir recursos, como una misma instancia de base de datos, o para centralizar servicios (como un reverse proxy con Traefik).

PASOS Y COMANDOS:

1. Crear la red externa (puedes usar el nombre que desees; aquí se usa "webnet"):
   ------------------------------------------------------------
   docker network create webnet
   ------------------------------------------------------------

2. Declarar la red externa en el archivo docker-compose.yml:
   ------------------------------------------------------------
   networks:
     webnet:
       external: true
   ------------------------------------------------------------

3. Conectar cada servicio a la red externa:
   En cada servicio de tu docker-compose.yml, agrega:
   ------------------------------------------------------------
   networks:
     - webnet
   ------------------------------------------------------------

4. Verificar la configuración de la red:
   ------------------------------------------------------------
   docker network inspect webnet
   ------------------------------------------------------------

NOTA:
Puedes nombrar la red como prefieras (por ejemplo, "webnet"). Lo importante es que todos tus servicios (Prestashop, Laravel, etc.) estén conectados a la misma red para poder compartir recursos y comunicarse entre sí.

------------------------------------------------------------
FIN DEL TUTORIAL: USO DE RED EXTERNA EN DOCKER COMPOSE
------------------------------------------------------------


