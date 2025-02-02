====================================================
    GESTIÓN Y MANTENIMIENTO DE DOCKER EN EL SERVIDOR
====================================================

Esta guía ofrece comandos básicos para detener contenedores, eliminarlos (para liberar espacio),
revisar el estado de Docker y realizar tareas de limpieza en el servidor.

----------------------------------------------------
1. Verificar el Estado de los Contenedores
----------------------------------------------------
Para ver qué contenedores están en ejecución (y su estado), usa:

  docker compose ps

O, para ver todos los contenedores (en ejecución y detenidos):

  docker ps -a

----------------------------------------------------
2. Detener Contenedores
----------------------------------------------------
Si deseas detener todos los contenedores definidos en el archivo docker-compose.yml, ejecuta:

  docker compose down

Este comando detiene y elimina los contenedores, pero por defecto mantiene los volúmenes y redes.

Si solo deseas detener los contenedores sin eliminarlos, puedes usar:

  docker compose stop

----------------------------------------------------
3. Eliminar Contenedores, Redes y Volúmenes
----------------------------------------------------
Para eliminar por completo los contenedores, redes y volúmenes (esto libera espacio, pero elimina datos almacenados en volúmenes, como la base de datos), usa:

  docker compose down -v

Si deseas eliminar además las imágenes generadas por docker-compose, puedes usar:

  docker compose down --rmi all -v

----------------------------------------------------
4. Limpiar Recursos Inactivos de Docker
----------------------------------------------------
Con el tiempo, Docker acumula contenedores detenidos, imágenes huérfanas y volúmenes que ya no se usan. Para limpiarlos, utiliza:

  docker system prune

Este comando eliminará:
  - Contenedores detenidos
  - Redes no utilizadas
  - Imágenes huérfanas
  - Caché de compilación
  
Para limpiar también los volúmenes, ejecuta:

  docker system prune --volumes

Atención: Revisa cuidadosamente la salida del comando, ya que eliminará recursos que no se estén utilizando, pudiendo perder datos importantes.

----------------------------------------------------
5. Verificar Uso de Recursos
----------------------------------------------------
Para ver cuánto espacio ocupan las imágenes, contenedores y volúmenes en tu sistema, usa:

  docker system df

Este comando te muestra un resumen del uso de espacio por:
  - Imágenes
  - Contenedores
  - Volúmenes
  - Caché de compilación

----------------------------------------------------
6. Verificar el Estado del Servicio Docker
----------------------------------------------------
Para comprobar que el servicio Docker esté corriendo correctamente en tu servidor, usa:

  sudo systemctl status docker

Verás información sobre el estado del servicio (activo, inactivo, errores, etc.).

----------------------------------------------------
Resumen de Comandos Útiles
----------------------------------------------------
- Ver contenedores en ejecución:
    docker compose ps
    docker ps -a

- Detener y eliminar contenedores (manteniendo volúmenes):
    docker compose down

- Detener y eliminar contenedores y volúmenes:
    docker compose down -v

- Detener y eliminar contenedores, volúmenes e imágenes:
    docker compose down --rmi all -v

- Limpiar recursos inactivos (sin volúmenes):
    docker system prune

- Limpiar recursos inactivos incluyendo volúmenes:
    docker system prune --volumes

- Ver uso de recursos:
    docker system df

- Ver estado del servicio Docker:
    sudo systemctl status docker

====================================================
        FIN DE LA GESTIÓN DE DOCKER
====================================================


