====================================================
          INSTALACIÓN DE DOCKER Y DOCKER COMPOSE
====================================================

Este documento describe los pasos necesarios para instalar Docker y Docker Compose 
(en su modalidad de plugin o binario) en un VPS con Ubuntu 22.04.

----------------------------------------------------
1. Actualiza el Sistema
----------------------------------------------------
Actualiza la lista de paquetes e instala las actualizaciones disponibles:

  sudo apt update
  sudo apt upgrade -y

----------------------------------------------------
2. Instala Dependencias Previas
----------------------------------------------------
Instala los paquetes necesarios para que apt pueda utilizar repositorios a través de HTTPS:

  sudo apt install apt-transport-https ca-certificates curl software-properties-common lsb-release -y

----------------------------------------------------
3. Agrega la Llave GPG Oficial de Docker
----------------------------------------------------
Descarga y guarda la llave GPG de Docker para verificar la autenticidad del paquete:

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

----------------------------------------------------
4. Agrega el Repositorio de Docker
----------------------------------------------------
Configura el repositorio estable de Docker usando el siguiente comando:

  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

----------------------------------------------------
5. Instala Docker Engine
----------------------------------------------------
Actualiza la base de datos de paquetes para incluir el nuevo repositorio e instala Docker Engine y sus componentes:

  sudo apt update
  sudo apt install docker-ce docker-ce-cli containerd.io -y

Verifica que Docker se haya instalado correctamente:

  docker --version

----------------------------------------------------
6. Permite Ejecutar Docker sin "sudo" (Opcional)
----------------------------------------------------
Para evitar tener que anteponer "sudo" en cada comando de Docker, añade tu usuario al grupo "docker":

  sudo usermod -aG docker $USER

Nota: Después de ejecutar este comando, cierra la sesión y vuelve a iniciarla para que los cambios surtan efecto.

----------------------------------------------------
7. Instala Docker Compose
----------------------------------------------------
Existen dos opciones para instalar Docker Compose:

Opción A: Instalar el Plugin de Docker Compose (Recomendado)
------------------------------------------------------------
Docker Compose V2 se integra como un plugin del comando "docker compose".
Instálalo con:

  sudo apt install docker-compose-plugin -y

Verifica la instalación ejecutando:

  docker compose version

Nota: Con esta opción, el comando a usar es "docker compose" (con espacio).

Opción B: Instalar Docker Compose como Binario Independiente
-------------------------------------------------------------
Si prefieres usar el comando clásico "docker-compose", sigue estos pasos:

1. Descarga el binario (reemplaza "v2.17.3" por la versión actual si es necesario):

  sudo curl -L "https://github.com/docker/compose/releases/download/v2.17.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

2. Otorga permisos de ejecución:

  sudo chmod +x /usr/local/bin/docker-compose

3. Verifica la instalación:

  docker-compose --version

----------------------------------------------------
8. Verifica la Instalación Completa
----------------------------------------------------
Para asegurarte de que tanto Docker como Docker Compose (plugin o binario) están funcionando correctamente, ejecuta:

- Para Docker:
  
  docker run hello-world

  Este comando descarga y ejecuta un contenedor de prueba que imprime un mensaje de bienvenida.

- Para Docker Compose (plugin o binario):

  docker compose version
  o
  docker-compose --version

Si ambos comandos muestran la versión instalada, ¡ya tienes Docker y Docker Compose instalados correctamente en tu VPS!

----------------------------------------------------
Resumen
----------------------------------------------------
1. Conéctate al VPS y actualiza el sistema.
2. Instala las dependencias necesarias.
3. Agrega la llave GPG y el repositorio de Docker.
4. Instala Docker Engine y verifica la instalación.
5. (Opcional) Agrega tu usuario al grupo "docker" para evitar usar "sudo".
6. Instala Docker Compose (usando el plugin o el binario).
7. Verifica la instalación ejecutando contenedores de prueba.

Con estos pasos, tendrás un entorno preparado para correr contenedores Docker en tu VPS y podrás avanzar con la configuración de tus proyectos (como tu aplicación Laravel).

====================================================
         FIN DE LA INSTALACIÓN DE DOCKER
====================================================

